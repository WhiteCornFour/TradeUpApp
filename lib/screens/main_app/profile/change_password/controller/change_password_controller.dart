import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/screens/general/general_email_sent.dart';
import 'package:tradeupapp/screens/main_app/index.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class ChangePasswordController extends GetxController {
  final emailController = TextEditingController();
  late BuildContext context;
  final auth = AuthServices();

  RxBool isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void handleResetPassword() async {
    try {
      isLoading.value = true;
      //kiem tra email nhap vao co hop le hay khong
      if (!emailController.text.contains('@') ||
          !emailController.text.contains('.')) {
        SnackbarHelperGeneral.showCustomSnackBar('Please enter a valid email!');
        return;
      }
      try {
        //kiem tra email nay co ton tai tren database hay khong
        final methods = await auth.checkEmailExists(emailController.text);
        if (methods) {
          SnackbarHelperGeneral.showCustomSnackBar(
            "This email has not been registered!",
          );
          return;
        }
        //Gui mot email de reset password
        await auth.resetPassword(email: emailController.text);
        SnackbarHelperGeneral.showCustomSnackBar(
          "Please check your email!.",
          backgroundColor: Colors.green,
        );
        //Chuyển sang trang email sent
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => EmailSentGeneral(destination: MainAppIndex()),
          ),
        );
      } catch (e) {
        SnackbarHelperGeneral.showCustomSnackBar(
          "An error occurred. Please try again later.",
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error handleSubmitReport: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
