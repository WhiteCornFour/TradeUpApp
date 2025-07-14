import 'package:flutter/material.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/utils/snackbar_helper.dart';
import 'package:tradeupapp/widgets/authentication_widgets/register_widgets/register_bottom_widget.dart';
import 'package:tradeupapp/widgets/authentication_widgets/register_widgets/register_button_widget.dart';
import 'package:tradeupapp/widgets/authentication_widgets/register_widgets/register_text_field_widget.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _yourNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final auth = AuthServices();
  final database = DatabaseService();

  @override
  void dispose() {
    _yourNameController.dispose();
    _userNameController.dispose();
    _passWordController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    final yourName = _yourNameController.text.trim();
    // final userName = _userNameController.text.trim();
    final passWord = _passWordController.text.trim();
    final email = _emailController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();

    //Kiem tra thong tin nguoi dung nhap vao
    String resultCheck = _checkInputData();
    if (resultCheck != 'NoError') {
      SnackbarHelper.showCustomSnackBar(context, resultCheck);
      return;
    }
    //Kiem tra email hien tai co trung hay khong?
    final emailExists = await auth.checkEmailExists(email);
    if (emailExists) {
      SnackbarHelper.showCustomSnackBar(
        context,
        "Email has been registered before!",
      );
    }

    try {
      await auth.signUp(email: email, password: passWord);
      await database.addUser(yourName, email, passWord, phoneNumber);
      SnackbarHelper.showCustomSnackBar(
        context,
        "Registration successful! Please check your email for verification.",
        backgroundColor: Colors.green,
        seconds: 3,
      );
      Navigator.pop(context);
    } catch (e) {
      print("Error: $e");
    }
  }

  //Function check infor of user
  String _checkInputData() {
    if (_yourNameController.text.isEmpty) {
      return 'Please enter your name!';
    }
    // if (_userNameController.text.isEmpty ||
    //     _userNameController.text.length < 8) {
    //   return 'Username must be at least 8 characters!';
    // }
    if (_passWordController.text.isEmpty ||
        _passWordController.text.length < 8) {
      return 'Password must be at least 8 characters!';
    }
    if (_emailController.text.isEmpty ||
        !_emailController.text.contains('@') ||
        !_emailController.text.contains('.')) {
      return 'Please enter a valid email!';
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
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
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
            Container(
              child: Text(
                "Register",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Roboto-Black',
                  letterSpacing: 2,
                ),
              ),
            ),
            Container(
              child: Text(
                "New here? Sign up and let’s grow together!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Roboto-Black',
                  letterSpacing: 1,
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFieldRegister(
              controller: _yourNameController,
              name: "Your name",
              obscureText: false,
            ),
            // TextInput(
            //   controller: _userNameController,
            //   name: "Username",
            //   obscureText: false,
            // ),
            TextFieldRegister(
              controller: _emailController,
              name: "Email",
              obscureText: false,
            ),
            TextFieldRegister(
              controller: _passWordController,
              name: "Password",
              obscureText: true,
            ),

            TextFieldRegister(
              controller: _phoneNumberController,
              name: "Phone number",
              obscureText: false,
            ),
            ButtonRegister(onPressed: _handleRegister),
            BottomRegister(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
