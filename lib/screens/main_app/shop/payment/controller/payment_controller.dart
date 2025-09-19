import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/firebase/notification_service.dart';
import 'package:tradeupapp/models/card_model.dart';
import 'package:tradeupapp/models/notification_model.dart';
import 'package:tradeupapp/models/offer_details_model.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/models/user_model.dart';
import 'package:tradeupapp/screens/main_app/index.dart';
import 'package:tradeupapp/screens/main_app/profile/profile.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class PaymentController extends GetxController {
  RxInt currentIndex = 0.obs;
  UserModel? currentUser;
  final idCurrentUser = AuthServices().currentUser!.uid;
  RxString shippingAddress = "".obs;
  TextEditingController newAddressController = TextEditingController();

  final ns = NotificationService();

  ProductModel? productModel;
  var cards = <CardModel>[].obs; // 🔥 dùng RxList
  var tempCards = <CardModel>[].obs; // card dùng 1 lần
  final db = DatabaseService();

  RxBool idLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _getDataCurrentUser();
    _handleFetchDataCards();
  }

  void _getDataCurrentUser() async {
    final data = await db.fetchDataCurrentUser();
    if (data != null) {
      currentUser = UserModel.fromMap(data);
      shippingAddress.value = currentUser!.address ?? "Add new address";
    }
  }

  void handleUpdateShippingAdress() async {
    await db.updateAddresUser(idCurrentUser, newAddressController.text);
  }

  void _handleFetchDataCards() async {
    final fetchedCards = await db.getCards(idCurrentUser);
    if (fetchedCards!.isNotEmpty) {
      cards.assignAll(fetchedCards); // 🔥 dùng assignAll thay vì gán trực tiếp
    }
  }

  void handleAddCard(CardModel card, {bool saveToDb = true}) async {
    if (saveToDb) {
      await db.addNewCard(idCurrentUser, card);
      _handleFetchDataCards();
    } else {
      tempCards.add(card);
      await db.addNewCard(idCurrentUser, card);
    }
  }

  void handleDeleteCard(String idCard) async {
    await db.updateStatusCardById(idCurrentUser, idCard);
    _handleFetchDataCards();
    SnackbarHelperGeneral.showCustomSnackBar(
      "Completed delete card!",
      backgroundColor: Colors.green,
    );
  }

  void handleAddOfferDetail(
    String offerId,
    OfferDetailsModel offerDetail,
    String productId,
    String productOwnerId,
  ) async {
    try {
      idLoading.value = true;

      await db.addOfferDetail(offerId, offerDetail, productId);

      await addCheckOutNotification(
        productOwnerId: productOwnerId,
        currentUserId: idCurrentUser,
        productId: productId,
      );

      Get.offAll(MainAppIndex());
    } catch (e) {
      // ignore: avoid_print
      print("Error handleAddOfferDetail: $e");
    } finally {
      idLoading.value = false;
    }
  }

  Future<void> addCheckOutNotification({
    required String productOwnerId,
    required String currentUserId,
    required String productId,
  }) async {
    try {
      //1. Tạo object Notification và lưu vào Firestore
      final notification = NotificationModel(
        targetUserId: productOwnerId,
        actorUserId: currentUserId,
        productId: productId,
        createdAt: Timestamp.now(),
        type: 4,
        isRead: 0,
        message: "has checked out for",
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

      //4. Gửi push notification cho tất cả token
      for (final token in tokens) {
        await ns.sendPushNotification(
          token: token,
          title: "Product Checkout",
          body: "$actorName has checked out for $productName",
        );
      }

      print("Offer notification sent successfully!");
    } catch (e) {
      print("Error addMakeAnOfferNotification: $e");
    }
  }
}
