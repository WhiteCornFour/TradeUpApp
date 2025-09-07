import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/screens/authentication/complete_personal_info.dart';
import 'package:tradeupapp/screens/authentication/login.dart';
import 'package:tradeupapp/screens/main_app/index.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class LoginController extends GetxController {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  void dispose() {
    controllerEmail.clear();
    controllerPassword.clear();
    super.dispose();
  }

  var isLogin = false.obs;

  //Nhan thông tin của User mới từ Register gửi qua
  String errorMessage = '';

  void signIn() async {
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();
    try {
      isLogin.value = true;
      //Đăng nhập
      final credential = await AuthServices().signIn(
        email: email,
        password: password,
      );
      //Reload lấy thông tin mới nhất
      final user = credential.user;
      await user?.reload();
      //Kiem tra tai khoan da verify chưa
      if (user != null && user.emailVerified) {
        SnackbarHelperGeneral.showCustomSnackBar(
          'Sign in sucessfull!!!',
          backgroundColor: Colors.green,
        );
        await Future.delayed(Duration(seconds: 2)); //Chờ 2 giây
        Get.offAll(() => MainAppIndex());
      } else {
        Get.replace(() => Login());
        await AuthServices().signOut();
      }
    } on FirebaseAuthException catch (_) {
      SnackbarHelperGeneral.showCustomSnackBar(
        "Something went wrong!",
        backgroundColor: Colors.red,
      );
    } finally {
      isLogin.value = false;
    }
  }

  void signInWithGoogle() async {
    try {
      isLogin.value = true;
      //Đăng nhập Google
      final userCredential = await authServices.value.signInWithGoogle();
      final user = userCredential.user;

      if (user == null) {
        SnackbarHelperGeneral.showCustomSnackBar(
          "User not found after sign in!",
        );
        return;
      }

      final uid = user.uid;

      //Kiểm tra xem đã có thông tin trong Firestore chưa
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        //Đã có thông tin thì vào trang chính
        SnackbarHelperGeneral.showCustomSnackBar(
          'Sign in sucessfull!',
          backgroundColor: Colors.green,
          seconds: 2,
        );
        await Future.delayed(Duration(seconds: 2)); //Chờ 2 giây
        Get.offAll(() => MainAppIndex());
      } else {
        //Chưa đủ thông tin chuyển sang trang điền thông tin
        Get.to(() => CompletePersonalInfoAuthentication());
      }
    } catch (e) {
      SnackbarHelperGeneral.showCustomSnackBar("Google SignIn failed!");
    } finally {
      isLogin.value = false;
    }
  }
}
