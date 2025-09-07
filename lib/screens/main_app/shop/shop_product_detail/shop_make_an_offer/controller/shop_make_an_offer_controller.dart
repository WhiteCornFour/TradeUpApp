import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/firebase/database_service.dart';
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

  final db = DatabaseService();

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
    required String reciverId,
    required String productId,
  }) async {
    if (offerAmount.value == null) {
      SnackbarHelperGeneral.showCustomSnackBar(
        "You can not send empty price!!!",
        backgroundColor: Colors.red,
      );
      return;
    } else if (senderId.isEmpty || senderId == '') {
      SnackbarHelperGeneral.showCustomSnackBar(
        "Something went wrong (UserID)! Please try again later!",
        backgroundColor: Colors.red,
      );
    } else if (productId.isEmpty || productId == '') {
      SnackbarHelperGeneral.showCustomSnackBar(
        "Something went wrong (ProductID)! Please try again later!",
        backgroundColor: Colors.red,
      );
    }

    isLoading(true);

    final offer = OfferModel(
      senderId: senderId,
      receiverId: reciverId,
      productId: productId,
      status: 0,
      price: originPrice.value,
      offerPrice: offerAmount.value,
      type: _getOfferType(),
      createdAt: Timestamp.now(),
    );

    await db.addOffer(offer);

    SnackbarHelperGeneral.showCustomSnackBar(
      "Send offer success!!",
      backgroundColor: Colors.green,
    );

    isLoading(false);

    Get.offAll(() => MainAppIndex());
  }

  //Hàm lấy offer type
  String _getOfferType() {
    if (offerAmount.value == null) return "same";
    final diff = offerAmount.value! - originPrice.value;
    if (diff > 0) return "raise";
    if (diff < 0) return "counter";
    return "same";
  }
}
