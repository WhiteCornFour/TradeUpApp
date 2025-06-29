import 'package:flutter/material.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/utils/snackbar_helper.dart';
import 'package:tradeupapp/widgets/authentication_widget/forgotpassword_widget/ButtonForgotPW_Widget.dart';
import 'package:tradeupapp/widgets/authentication_widget/forgotpassword_widget/TextInput_Widget.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final TextEditingController _emailFPController = TextEditingController();

  final auth = AuthService();
  void _handleForgotPassWord() async {
    final email = _emailFPController.text.trim();
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      SnackbarHelper.showCustomSnackBar(context, 'Please enter a valid email!');
      return;
    }
    try {
      await auth.forgotPassword(email);
      SnackbarHelper.showCustomSnackBar(
        context,
        'Password reset email has been sent!',
        backgroundColor: Colors.green,
        seconds: 3
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            IconButton(
              padding: EdgeInsets.only(right: 50),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 30,
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/assets/images/logo-transparent.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Forgot password?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: 'Roboto-Bold',
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Enter the email associated with your account\nend we will send an email with instructions to\nreset your password.',
              style: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            TextInput(
              controller: _emailFPController,
              name: "Email",
              obscureText: false,
            ),
            ButtonForgotPW_Widget(onPressed: _handleForgotPassWord),
          ],
        ),
      ),
    );
  }
}
