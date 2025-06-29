import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/AppColors.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/screens/authentication/forgotpassword.dart';
import 'package:tradeupapp/screens/authentication/register.dart';
import 'package:tradeupapp/screens/main_app/index.dart';
import 'package:tradeupapp/widgets/authentication_widget/login_widget/input_field_login_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  String errorMessage = '';

  void signIn() async {
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();
    try {
      await authServices.value.signIn(email: email, password: password);
      if (!mounted) return; //neu widget da dispose thi chuyen trang
      Navigator.push(context, MaterialPageRoute(builder: (context) => Index()));
    } on FirebaseAuthException catch (e) {
      if (!mounted) return; //dam bao context con truoc khi hien thi Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Something went wrong!")),
      );
    }
  }

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
                              fontSize: 25,
                              fontFamily: 'Roboto-Black',
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: <Widget>[
                            CustomInputField(
                              controller: controllerEmail,
                              label: 'Email',
                            ),
                            CustomInputField(
                              controller: controllerPassword,
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
                          onPressed: signIn,
                          color: AppColors.header,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontFamily: 'Roboto-Bold',
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
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: 'Roboto-Regular',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 36),
                    child: OutlinedButton(
                      onPressed: () async {
                        try {
                          await authServices.value.signInWithGoogle();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Index()),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Đăng nhập bằng Google thất bại"),
                            ),
                          );
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        side: BorderSide(color: Colors.black, width: 1),
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
                            "lib/assets/images/google_icon.png",
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
                        onPressed: () {
                          // register();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
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
