import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/authentication/controllers/login_controller.dart';
import 'package:tradeupapp/screens/authentication/forgot_password.dart';
import 'package:tradeupapp/screens/authentication/register.dart';
import 'package:tradeupapp/screens/debug/debug.dart';
import 'package:tradeupapp/widgets/authentication_widgets/login_widgets/login_text_field_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
      body: SizedBox(
        height: MediaQuery.of(
          context,
        ).size.height, //lay toan bo chieu cao man hinh
        width: double.infinity, //lay toan bo chieu rong cua man hinh
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                //chiem toan bo chieu cao co the co trong cot
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36),
                    child: Column(
                      children: [
                        GestureDetector(
                          onLongPress: () {
                            Get.to(() => DebugMenu());
                          },
                          child: Image.asset(
                            "assets/images/logo-transparent.png",
                            width: 150,
                            height: 150,
                          ),
                        ),

                        SizedBox(height: 40),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Login to your Account",
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Roboto-Black',
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: <Widget>[
                            TextFieldLogin(
                              controller: loginController.controllerEmail,
                              label: 'Email',
                            ),
                            TextFieldLogin(
                              controller: loginController.controllerPassword,
                              label: 'Password',
                              obscureText: true,
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 190),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Forgotpassword(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'Roboto-Bold',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        MaterialButton(
                          minWidth: double.infinity,
                          height: 50,
                          onPressed: loginController.signIn,
                          color: AppColors.background,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontFamily: 'Roboto-Bold',
                              fontSize: 15,
                              color: AppColors.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Or sign in with",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: 'Roboto-Regular',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 36),
                    child: OutlinedButton(
                      onPressed: loginController.signInWithGoogle,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        side: BorderSide(color: AppColors.background, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/google_icon.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 10),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 12),
                            width: 1,
                            height: 24,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Continue with Google",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Roboto-Regular',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: 'Roboto-Regular',
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.to(Register()),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.header,
                            fontFamily: 'Roboto-Bold',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
