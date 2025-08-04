import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/profile/change_password/controller/change_password_controller.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/change_password_widgets/change_password_button_submit_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/change_password_widgets/change_password_text_field_widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final changePasswordController = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    changePasswordController.context = context;
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
                BackButtonCustomGeneral(),
                SizedBox(height: 40),
                Center(
                  child: Container(
                    width: 260,
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/changepassword-vector.jpg',
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
                  controller: changePasswordController.emailController,
                ),
                SizedBox(height: 10),
                ButtonSubmitChangePassword(
                  onPressed: changePasswordController.handleResetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
