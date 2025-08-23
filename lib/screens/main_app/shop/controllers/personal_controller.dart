import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/models/user_model.dart';
import 'package:tradeupapp/screens/main_app/chat/message.dart';
import 'package:tradeupapp/widgets/general/general_custom_dialog.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class PersonalController extends GetxController {
  final String idUser;
  PersonalController({required this.idUser});

  Rxn<UserModel> userData = Rxn<UserModel>();
  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxDouble rating = 0.0.obs;
  //Khai bao bien db
  final db = DatabaseService();

  BuildContext? context;

  @override
  void onInit() {
    super.onInit();
    _fetchUserDataById();
    _fetchProducts();
  }

  void _fetchUserDataById() async {
    userData.value = await db.fetchUserModelById(idUser);
    _calculatorRating();
  }

  void _calculatorRating() {
    if (userData.value != null) {
      final totalReviews = (userData.value!.totalReviews ?? 0).toDouble();
      final totalRating = (userData.value!.rating ?? 0).toDouble();

      if (totalReviews > 0) {
        double avg = totalRating / totalReviews;
        rating.value = double.parse(
          avg.toStringAsFixed(1),
        ); // Làm tròn 1 chữ số
      } else {
        rating.value = 0.0;
      }
    }
  }

  void _fetchProducts() async {
    productList.value = await db.getProductByIdUser(idUser);
  }

  void handleUpdateRating(double ratepoint) async {
    double newRatepoint;
    int newTotalRating;
    if (userData.value!.rating == null &&
        userData.value!.total_reviews == null) {
      newRatepoint = ratepoint;
      newTotalRating = 1;
    } else {
      newRatepoint = ratepoint + userData.value!.rating!;
      newTotalRating = userData.value!.totalReviews! + 1;
    }
    await db.updateUserRating(idUser, newRatepoint, newTotalRating);
    SnackbarHelperGeneral.showCustomSnackBar(
      'Rating successfully!',
      backgroundColor: Colors.green,
    );
    //Load lại dữ liệu
    _fetchUserDataById();
  }

  void handleSendMessage() async {
    final idCurrentUser = AuthServices().currentUser!.uid;

    String? result = await db.checkChatRoomStatus(idCurrentUser, idUser);

    if (result == "Block") {
      CustomDialogGeneral.show(
        context!,
        'Messaging blocked',
        'You have blocked this user. Unblock them to continue chatting.',
        () async {
          String? newId = await db.createNewChatRoom(idCurrentUser, idUser);
          if (newId != null) {
            // ignore: avoid_print
            print('Created new chat room with ID: $newId');
            Get.to(Message(idOtherUser: idUser, idChatRoom: newId));
          }
        },
        image: 'warning.jpg',
        numberOfButton: 2,
        textButton1: 'Yes',
        textButton2: 'No',
      );
      return;
    }

    if (result != null) {
      // Tồn tại phòng và không bị block
      // ignore: avoid_print
      print('Chat room exists with ID: $result');
      db.updateStatusRoom(result, 0);
      Get.to(Message(idOtherUser: idUser, idChatRoom: result));
    } else {
      // Không tồn tại phòng → tạo mới
      String? newId = await db.createNewChatRoom(idCurrentUser, idUser);
      if (newId != null) {
        // ignore: avoid_print
        print('Created new chat room with ID: $newId');
        Get.to(Message(idOtherUser: idUser, idChatRoom: newId));
      }
    }
  }
}
