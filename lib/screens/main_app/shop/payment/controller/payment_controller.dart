import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/card_model.dart';
import 'package:tradeupapp/models/offer_details_model.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/models/user_model.dart';
import 'package:tradeupapp/screens/main_app/profile/profile.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class PaymentController extends GetxController {
  RxInt currentIndex = 0.obs;
  UserModel? currentUser;
  final idCurrentUser = AuthServices().currentUser!.uid;
  RxString shippingAddress = "".obs;
  TextEditingController newAddressController = TextEditingController();

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
    String productId
  ) async {
    try {
      idLoading.value = true;

      await db.addOfferDetail(offerId, offerDetail, productId);
      Get.off(Profile());
    } catch (e) {
      // ignore: avoid_print
      print("Error handleAddOfferDetail: $e");
    } finally {
      idLoading.value = false;
    }
  }
}
