import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/AppColors.dart';
import 'package:tradeupapp/widgets/authentication_widget/register_widget/BottomRegister_Widget.dart';
import 'package:tradeupapp/widgets/authentication_widget/register_widget/ButtonRegister_Widget.dart';
import 'package:tradeupapp/widgets/authentication_widget/register_widget/TextInput_Widget.dart';

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
  final TextEditingController _numberPhoneController = TextEditingController();
  @override
  void dispose() {
    _yourNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          padding: EdgeInsetsGeometry.all(15),
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
                      image: AssetImage(
                        "lib/assets/images/logo-transparent.png",
                      ),
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
                    color: AppColors.text,
                    fontSize: 35,
                    fontFamily: 'Roboto-Black',
                    letterSpacing: 2,
                  ),
                ),
              ),
              Container(
                child: Text(
                  "New here? Sign up and let’s grow together!",
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 15,
                    fontFamily: 'Roboto-Black',
                    letterSpacing: 1,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextInput(controller: _yourNameController, name: "Your name"),
              TextInput(controller: _userNameController, name: "Username"),
              TextInput(controller: _passWordController, name: "Password"),
              TextInput(controller: _emailController, name: "Email"),
              TextInput(
                controller: _numberPhoneController,
                name: "Phone number",
              ),
              ButtonRegister_Widget(
                onPressed: () {
                  // Xử lý đăng ký ở đây
                  print("Tên: ${_yourNameController.text}");
                  print("Username: ${_userNameController.text}");
                  print("Mật khẩu: ${_passWordController.text}");
                  print("Email: ${_emailController.text}");
                  print("SĐT: ${_numberPhoneController.text}");
                  // TODO: Thêm validate và gửi data
                },
              ),
              BottomRegister_Widget(),
            ],
          ),
        ),
      ),
    );
  }
}
