import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/screens/authentication/login.dart';
import 'package:tradeupapp/screens/general/general_email_sent.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class ForgotPasswordController extends GetxController {
  final emailFPController = TextEditingController();
  final auth = AuthServices();

  late BuildContext context;

  @override
  void onClose() {
    emailFPController.dispose();
    super.onClose();
  }

  void handleForgotPassWord() async {
    final email = emailFPController.text.trim();
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      SnackbarHelperGeneral.showCustomSnackBar(
        
        'Please enter a valid email!',
      );
      return;
    }
    try {
      await auth.forgotPassword(email);
      emailFPController.text = '';
      SnackbarHelperGeneral.showCustomSnackBar(
        // ignore: use_build_context_synchronously
        
        'Password reset email has been sent!',
        backgroundColor: Colors.green,
        seconds: 3,
      );
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => EmailSentGeneral(destination: Login()),
        ),
      );
    } catch (e) {
      SnackbarHelperGeneral.showCustomSnackBar(
        // ignore: use_build_context_synchronously
        
        'Error: $e',
        backgroundColor: Colors.red,
        seconds: 1,
      );
    }
  }
}
