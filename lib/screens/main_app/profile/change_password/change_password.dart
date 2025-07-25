import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';
import 'package:tradeupapp/utils/back_button.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/change_password_widgets/change_password_text_field_widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                //Nut back
                BackButtonCustom(),
                SizedBox(height: 60),
                Center(
                  child: Container(
                    width: 260,
                    height: 250,
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
                SizedBox(height: 10),
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
                    onPressed: () {},
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