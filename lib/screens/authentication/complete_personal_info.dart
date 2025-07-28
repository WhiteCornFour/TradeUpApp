import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/screens/main_app/index.dart';
import 'package:tradeupapp/utils/snackbar_helper.dart';
import 'package:tradeupapp/widgets/authentication_widgets/login_widgets/login_text_field_widget.dart';

class CompletePersonalInfoAuthentication extends StatefulWidget {
  const CompletePersonalInfoAuthentication({super.key});

  @override
  State<CompletePersonalInfoAuthentication> createState() =>
      _CompletePersonalInfoAuthenticationState();
}

class _CompletePersonalInfoAuthenticationState
    extends State<CompletePersonalInfoAuthentication> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  void _onContinue() async {
    final name = _nameController.text.trim();
    final phone = _phoneNumberController.text.trim();

    //Kiểm tra thông tin người dùng nhập vô
    String resultCheck = _checkInputData();
    if (resultCheck != 'NoError') {
      SnackbarHelper.showCustomSnackBar(context, resultCheck);
      return;
    }

    //Lấy email từ người dùng Google đã đăng nhập
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      SnackbarHelper.showCustomSnackBar(context, "User is not logged in.");
      return;
    }

    final email = user.email ?? '';
    //Gọi hàm thêm User
    await DatabaseService().addUser(
      yourName: name,
      passWord: '',
      email: email,
      phoneNumber: phone,
    );

    if (!mounted) return;
    SnackbarHelper.showCustomSnackBar(context, 'Sign Up Form Complete!!!');
    Get.offAll(() => MainAppIndex());
  }

  String _checkInputData() {
    if (_nameController.text.isEmpty) {
      return 'Please enter your name!';
    }
    if (_phoneNumberController.text.isEmpty ||
        _phoneNumberController.text.length != 10 ||
        !RegExp(r'^[0-9]+$').hasMatch(_phoneNumberController.text)) {
      return 'Please enter a valid 10-digit phone number!';
    }

    return 'NoError';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36),
            child: Column(
              children: [
                //Image Gif
                Image.asset(
                  "assets/images/complete_profile.gif",
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                SizedBox(height: 20),
                Text(
                  "Complete your profile",
                  style: TextStyle(
                    fontFamily: 'Roboto-Bold',
                    fontSize: 22,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  "We all most got there,please fill your name and phone number to complete sign up.",
                  style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFieldLogin(controller: _nameController, label: 'Full Name'),
                TextFieldLogin(
                  controller: _phoneNumberController,
                  label: 'Phone Number',
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _onContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.header,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        fontFamily: 'Roboto-Bold',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
