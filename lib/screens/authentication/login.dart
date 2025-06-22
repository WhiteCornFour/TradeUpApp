import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/color/color.dart';
import 'package:tradeupapp/widgets/authentication_widget/login_widget/input_field_login_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                //chiem toan bo chieu cao co the co trong cot
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36),
                      child: Column(
                        children: [
                          Image.asset(
                            "lib/assets/images/logo-transparent.png",
                            width: 150,
                            height: 150,
                          ),
                          SizedBox(height: 40),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Login to your Account",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Column(
                            children: <Widget>[
                              CustomInputField(label: 'Username'),
                              CustomInputField(label: 'Password', obscureText: true),
                            ],
                          ),
                          SizedBox(height: 10),
                          MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {},
                            color: AppColor.blackblue,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white,
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
                        fontWeight: FontWeight.w200,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "lib/assets/images/google_icon.png",
                          width: 26,
                          height: 26,
                        ),
                        Image.asset(
                          "lib/assets/images/facebook_icon.png",
                          width: 26,
                          height: 26,
                        ),
                        Image.asset(
                          "lib/assets/images/twitter_icon.png",
                          width: 26,
                          height: 26,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColor.blackblue,
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
      ),
    );
  }
}
