import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/screens/authentication/complete_personal_info.dart';
import 'package:tradeupapp/screens/authentication/forgot_password.dart';
import 'package:tradeupapp/screens/authentication/register.dart';
import 'package:tradeupapp/screens/debug/debug.dart';
import 'package:tradeupapp/screens/main_app/index.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';
import 'package:tradeupapp/widgets/authentication_widgets/login_widgets/login_text_field_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  void dispose() {
    controllerEmail.clear();
    controllerPassword.clear();
    super.dispose();
  }

  //Nhan thông tin của User mới từ Register gửi qua
  String errorMessage = '';

  void signIn() async {
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();
    try {
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
        if (!mounted) return;
        SnackbarHelperGeneral.showCustomSnackBar(
          context,
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
      if (!mounted) return;
      SnackbarHelperGeneral.showCustomSnackBar(
        context,
        "Something went wrong!",
        backgroundColor: Colors.red,
      );
    }
  }

  void signInWithGoogle() async {
    try {
      //Đăng nhập Google
      final userCredential = await authServices.value.signInWithGoogle();
      final user = userCredential.user;

      if (user == null) {
        if (!mounted) return;
        SnackbarHelperGeneral.showCustomSnackBar(
          context,
          "User not found after sign in!",
        );
        return;
      }

      // //Kiểm tra nếu email đã tồn tại với phương thức khác
      // final signInMethods = await FirebaseAuth.instance
      //     .fetchSignInMethodsForEmail(user.email!);

      // if (signInMethods.contains('password')) {
      //
      //   await FirebaseAuth.instance.signOut(); //Sign out khỏi tài khoản Google
      //   SnackbarHelper.showCustomSnackBar(
      //     context,
      //     "This email was registered manually. Please sign in with Email & Password.",
      //   );
      //   return;
      // }

      final uid = user.uid;

      //Kiểm tra xem đã có thông tin trong Firestore chưa
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        //Đã có thông tin thì vào trang chính
        if (!mounted) return;
        SnackbarHelperGeneral.showCustomSnackBar(
          context,
          'Sign in sucessfull!',
          backgroundColor: Colors.green,
        );
        await Future.delayed(Duration(seconds: 2)); //Chờ 2 giây
        Get.offAll(() => MainAppIndex());
      } else {
        //Chưa đủ thông tin chuyển sang trang điền thông tin
        Get.to(() => const CompletePersonalInfoAuthentication());
      }
    } catch (e) {
      if (!mounted) return;
      SnackbarHelperGeneral.showCustomSnackBar(
        context,
        "Google SignIn failed!",
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
                              controller: controllerEmail,
                              label: 'Email',
                            ),
                            TextFieldLogin(
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
                      onPressed: signInWithGoogle,
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
