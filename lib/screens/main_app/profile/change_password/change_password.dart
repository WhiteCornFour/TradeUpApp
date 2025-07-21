import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/screens/main_app/emailsent.dart';
import 'package:tradeupapp/screens/main_app/index.dart';
import 'package:tradeupapp/utils/back_button.dart';
import 'package:tradeupapp/utils/snackbar_helper.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/change_password_widgets/change_password_text_field_widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _controller = TextEditingController();

  final auth = AuthServices();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleResetPassword() async {
    //kiem tra email nhap vao co hop le hay khong
    if (!_controller.text.contains('@') || !_controller.text.contains('.')) {
      SnackbarHelper.showCustomSnackBar(context, 'Please enter a valid email!');
      return;
    }
    try {
      //kiem tra email nay co ton tai tren database hay khong
      final methods = await auth.checkEmailExists(_controller.text);
      if (methods) {
        SnackbarHelper.showCustomSnackBar(
          context,
          "This email has not been registered!",
        );
        return;
      }
      //Gui mot email de reset password
      await auth.resetPassword(email: _controller.text);
      SnackbarHelper.showCustomSnackBar(
        context,
        "Please check your email!.",
        backgroundColor: Colors.green,
      );
      //Chuyển sang trang email sent
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmailSent(destination: Index()),
        ),
      );
    } catch (e) {
      SnackbarHelper.showCustomSnackBar(
        context,
        "An error occurred. Please try again later.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                //Nut back
                BackButtonCustom(),
                SizedBox(height: 40),
                Center(
                  child: Container(
                    width: 260,
                    height: 230,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'lib/assets/images/changepassword-vector.jpg',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Change password',
                  style: TextStyle(
                    color: AppColors.header,
                    fontSize: 25,
                    fontFamily: 'Roboto-Black',
                  ),
                ),

                Text(
                  'Enter the email associated with your account${'\n'}and we wi${"'"}ll send an email with instructions${'\n'}to reset your password.',
                  style: TextStyle(
                    color: AppColors.header,
                    fontFamily: 'Roboto-Regular',
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 15),
                TextFieldChangePassword(
                  label: 'Email',
                  controller: _controller,
                ),
                SizedBox(height: 10),
                Center(
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    color: AppColors.header,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: _handleResetPassword,
                    child: Text(
                      'Send Instructions',
                      style: TextStyle(
                        color: AppColors.text,
                        fontFamily: 'Roboto-Medium',
                        fontSize: 15,
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
