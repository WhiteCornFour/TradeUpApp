import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/screens/authentication/controllers/forgot_password_controller.dart';
import 'package:tradeupapp/widgets/authentication_widgets/forgotpassword_widgets/forgot_password_button_widget.dart';
import 'package:tradeupapp/widgets/authentication_widgets/forgotpassword_widgets/forgot_password_text_field_widget.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final forgotPasswordController = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    forgotPasswordController.context = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              BackButtonCustomGeneral(),

              SizedBox(height: 40),
              Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo-transparent.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40),
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
              TextFieldForgotPassword(
                controller: forgotPasswordController.emailFPController,
                name: "Email",
                obscureText: false,
              ),

              ButtonForgotPassword(
                onPressed: forgotPasswordController.handleForgotPassWord,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
