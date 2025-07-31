import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/screens/authentication/controllers/register_controller.dart';
import 'package:tradeupapp/widgets/authentication_widgets/register_widgets/register_bottom_widget.dart';
import 'package:tradeupapp/widgets/authentication_widgets/register_widgets/register_button_widget.dart';
import 'package:tradeupapp/widgets/authentication_widgets/register_widgets/register_text_field_widget.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    registerController.context = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      image: AssetImage("assets/images/logo-transparent.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Register",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Roboto-Black',
                  letterSpacing: 2,
                ),
              ),
              Text(
                "New here? Sign up and let’s grow together!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Roboto-Black',
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 10),

              //your name
              TextFieldRegister(
                controller: registerController.yourNameController,
                name: "Your name",
                obscureText: false,
              ),

              //Email
              TextFieldRegister(
                controller: registerController.emailController,
                name: "Email",
                obscureText: false,
              ),

              //Password
              TextFieldRegister(
                controller: registerController.passwordController,
                name: "Password",
                obscureText: true,
              ),

              //Phone number
              TextFieldRegister(
                controller: registerController.phonenumberController,
                name: "Phone number",
                obscureText: false,
              ),

              ButtonRegister(onPressed: registerController.handleRegister),

              BottomRegister(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
