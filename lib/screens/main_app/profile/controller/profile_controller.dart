import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/user_model.dart';
import 'package:tradeupapp/widgets/general/general_custom_dialog.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class ProfileController extends GetxController {
  Rx<bool> isBusinessMode = false.obs;
  var user = Rxn<UserModel>();
  final isLoading = false.obs;

  late BuildContext context;
  //Khai báo biến database
  final db = DatabaseService();
  @override
  void onInit() {
    listenUser();
    super.onInit();
  }

  //load user data from firebase
  Future<void> loadUser() async {
    isLoading.value = true;
    try {
      final data = await DatabaseService().fetchDataCurrentUser();
      if (data != null) {
        user.value = UserModel.fromMap(data);
        isBusinessMode.value = user.value?.role != 1;
      }
    } catch (e) {
      SnackbarHelperGeneral.showCustomSnackBar(
        'Error: $e',
        backgroundColor: Colors.red,
        seconds: 1,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void listenUser() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .snapshots()
        .listen((doc) {
          if (doc.exists) {
            user.value = UserModel.fromMap(doc.data()!);
            isBusinessMode.value = user.value?.role != 1;
          }
        });
  }

  // Đăng xuất
  Future<void> _logout() async {
    try {
      await authServices.value.signOut();
      await GoogleSignIn().signOut();
      Get.offAllNamed('/login');
    } catch (e) {
      SnackbarHelperGeneral.showCustomSnackBar(
        'Error: $e',
        backgroundColor: Colors.red,
        seconds: 1,
      );
    }
  }

  void handleLogout() {
    CustomDialogGeneral.show(
      context,
      'Log out',
      'Are you sure you want to log out?',
      () {
        _logout();
      },
      numberOfButton: 2,
    );
  }

  // Cập nhật Role người dùng
  Future<void> updateUserRole(int role) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) throw Exception("User not logged in");

      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(currentUser.uid)
      //     .update({'role': role});
      await db.updateUserRoleDB(currentUser.uid, role);

      isBusinessMode.value = role != 1;
      await loadUser(); // reload dữ liệu người dùng
    } catch (e) {
      SnackbarHelperGeneral.showCustomSnackBar(
        'Error: $e',
        backgroundColor: Colors.red,
        seconds: 1,
      );
    }
  }

  //Chuyển trang tương ứng
  void navigatorFunc(Widget screen) {
    Get.to(() => screen);
  }
}
