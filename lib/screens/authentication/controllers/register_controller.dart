import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/screens/authentication/login.dart';
import 'package:tradeupapp/screens/general/general_email_sent.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class RegisterController extends GetxController {
  final yourNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phonenumberController = TextEditingController();

  final auth = AuthServices();
  final database = DatabaseService();

  late BuildContext context;

  @override
  void onClose() {
    yourNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phonenumberController.dispose();
    super.onClose();
  }

  void handleRegister() async {
    final yourName = yourNameController.text.trim();
    final passWord = passwordController.text.trim();
    final email = emailController.text.trim();
    final phoneNumber = phonenumberController.text.trim();

    //Kiem tra thong tin nguoi dung nhap vao
    String resultCheck = _checkInputData();
    if (resultCheck != 'NoError') {
      SnackbarHelperGeneral.showCustomSnackBar(context, resultCheck);
      return;
    }
    //Kiem tra email hien tai co trung hay khong?
    final emailExists = await auth.checkEmailExists(email);
    if (emailExists) {
      SnackbarHelperGeneral.showCustomSnackBar(
        // ignore: use_build_context_synchronously
        context,
        "Email has been registered before!",
      );
    }

    try {
      await auth.signUp(email: email, password: passWord);
      await database.addUser(
        yourName: yourName,
        passWord: passWord,
        email: email,
        phoneNumber: phoneNumber,
      );
      SnackbarHelperGeneral.showCustomSnackBar(
        // ignore: use_build_context_synchronously
        context,
        "Registration successful! Please check your email for verification.",
        backgroundColor: Colors.green,
        seconds: 1,
      );
      //Chuyen sang trang email sent
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => EmailSentGeneral(destination: Login()),
        ),
      );
    } catch (e) {
      // ignore: avoid_print
      print("Error: $e");
    }
  }

  //Function check infor of user
  String _checkInputData() {
    if (yourNameController.text.isEmpty) {
      return 'Please enter your name!';
    }
    if (passwordController.text.isEmpty || passwordController.text.length < 8) {
      return 'Password must be at least 8 characters!';
    }
    if (emailController.text.isEmpty ||
        !emailController.text.contains('@') ||
        !emailController.text.contains('.')) {
      return 'Please enter a valid email!';
    }
    if (phonenumberController.text.isEmpty ||
        phonenumberController.text.length != 10 ||
        !RegExp(r'^[0-9]+$').hasMatch(phonenumberController.text)) {
      return 'Please enter a valid 10-digit phone number!';
    }

    return 'NoError';
  }
}
