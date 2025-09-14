import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/firebase/notification_service.dart';
import 'package:tradeupapp/models/notification_model.dart';
import 'package:tradeupapp/models/offer_model.dart';
import 'package:tradeupapp/screens/main_app/index.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class MakeAnOfferController extends GetxController {
  ///-----------
  /// Variables (Danh sách các biến khai báo trong Controller)
  ///-----------

  //Giá gốc sản phẩm
  final RxDouble originPrice = 0.0.obs;

  //Giá người dùng nhập vào
  final RxnDouble offerAmount = RxnDouble();

  //Trang thai loading
  var isLoading = false.obs;

  //Gọi service từ Database
  final db = DatabaseService();

  //Gọi service từ Firebase Cloud Messaging
  final ns = NotificationService();

  ///----------------------
  /// Hàm quản lý trạng thái của Price Caculator
  ///----------------------
  //Cập nhật khi mà người dùng nhập giá
  void updatePrice(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9.]'), '');
    offerAmount.value = double.tryParse(cleaned);
  }

  //Hàm thêm offer mới
  Future<void> createOffer({
    required String senderId,
    required String receiverId,
    required String productId,
  }) async {
    if (offerAmount.value == null) {
      SnackbarHelperGeneral.showCustomSnackBar(
        "You can not send empty price!!!",
        backgroundColor: Colors.red,
      );
      return;
    } else if (senderId.isEmpty) {
      SnackbarHelperGeneral.showCustomSnackBar(
        "Something went wrong (UserID)! Please try again later!",
        backgroundColor: Colors.red,
      );
      return;
    } else if (productId.isEmpty) {
      SnackbarHelperGeneral.showCustomSnackBar(
        "Something went wrong (ProductID)! Please try again later!",
        backgroundColor: Colors.red,
      );
      return;
    }

    isLoading(true);

    final offer = OfferModel(
      senderId: senderId,
      receiverId: receiverId,
      productId: productId,
      status: 0,
      price: originPrice.value,
      offerPrice: offerAmount.value,
      type: _getOfferType(),
      createdAt: Timestamp.now(),
    );

    try {
      //1. Thêm offer và lấy docId
      final offerId = await db.addOffer(offer);

      //2. Thêm notification liền sau đó
      await addMakeAnOfferNotification(
        productOwnerId: receiverId,
        currentUserId: senderId,
        productId: productId,
        offerId: offerId,
        offerType: _getOfferType(),
      );

      SnackbarHelperGeneral.showCustomSnackBar(
        "Send offer success!!",
        backgroundColor: Colors.green,
      );

      Get.offAll(() => MainAppIndex());
    } catch (e) {
      SnackbarHelperGeneral.showCustomSnackBar(
        "Error when sending offer: $e",
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading(false);
    }
  }

  //Hàm lấy offer type
  String _getOfferType() {
    if (offerAmount.value == null) return "same";
    final diff = offerAmount.value! - originPrice.value;
    if (diff > 0) return "raise";
    if (diff < 0) return "counter";
    return "same";
  }

  ///----------------------
  /// Add Notification + Push
  ///----------------------
  Future<void> addMakeAnOfferNotification({
    required String productOwnerId,
    required String currentUserId,
    required String productId,
    required String offerId,
    required String offerType,
  }) async {
    try {
      //1. Tạo object Notification và lưu vào Firestore
      final notification = NotificationModel(
        targetUserId: productOwnerId,
        actorUserId: currentUserId,
        productId: productId,
        offerId: offerId,
        createdAt: Timestamp.now(),
        type: 3,
        isRead: 0,
        message: "sent you an offer",
      );

      await db.addNotification(notification);

      //2. Lấy danh sách token của người nhận
      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(productOwnerId)
          .get();

      if (!userDoc.exists) {
        print("Receiver user not found!");
        return;
      }

      final tokens = List<String>.from(userDoc.data()?["fcmTokens"] ?? []);
      if (tokens.isEmpty) {
        print("Receiver has no FCM tokens!");
        return;
      }

      //3. Lấy thêm thông tin để hiển thị thông báo rõ ràng
      final actorDoc = await db.fetchUserModelById(currentUserId);
      final actorName = actorDoc?.fullName ?? 'Someone';

      final productDoc = await db.getProductById(productId);
      final productName = productDoc?.productName ?? 'your product';

      final offer = await db.getOfferById(offerId);

      //4. Format theo offerType
      String verb;
      if (offerType == 'raise') {
        verb = 'up to';
      } else if (offerType == 'counter') {
        verb = 'down to';
      } else {
        verb = '';
      }

      final priceText = offer?.offerPrice != null
          ? "${offer!.offerPrice}\$"
          : "";

      //5. Gửi push notification cho tất cả token
      for (final token in tokens) {
        await ns.sendPushNotification(
          token: token,
          title: "New Offer",
          body:
              "$actorName sent you an offer for $productName $verb $priceText",
        );
      }

      print("Offer notification sent successfully!");
    } catch (e) {
      print("Error addMakeAnOfferNotification: $e");
    }
  }
}
