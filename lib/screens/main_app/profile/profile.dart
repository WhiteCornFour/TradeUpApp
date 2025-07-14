import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/screens/authentication/login.dart';
import 'package:tradeupapp/screens/main_app/profile/about_us/about_us.dart';
import 'package:tradeupapp/screens/main_app/profile/change_password/change_password.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/user_profile_appbar_custom_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/user_profile_business_mode_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/user_profile_category_function_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  bool isBusinessMode = false;

  void _logout() async {
    try {
      await authServices.value.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  void _navigatorFunc(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppbarCustomUserProfile(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              //Business
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 240, 240, 240),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 7, top: 5),
                      child: Text(
                        'Business',
                        style: TextStyle(
                          color: AppColors.header,
                          fontFamily: 'Roboto-Medium',
                          fontSize: 14,
                        ),
                      ),
                    ),

                    BusinessModeUserProfile(
                      label: 'Business mode',
                      icon: Icons.business_center_outlined,
                      value: isBusinessMode,
                      onChanged: (value) {
                        setState(() {
                          isBusinessMode = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7),
              //Activity
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 240, 240, 240),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 7, top: 5),
                      child: Text(
                        'Activity',
                        style: TextStyle(
                          color: AppColors.header,
                          fontFamily: 'Roboto-Medium',
                          fontSize: 14,
                        ),
                      ),
                    ),

                    //Buy history
                    CategoryFuncUserProfile(
                      onTap: () {},
                      icon: Icons.history,
                      label: 'Buy history',
                    ),

                    //Sales history
                    CategoryFuncUserProfile(
                      onTap: () {},
                      icon: Icons.history,
                      label: 'Sales history',
                    ),

                    //Report
                    CategoryFuncUserProfile(
                      onTap: () {},
                      icon: Icons.report_outlined,
                      label: 'Report',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7),
              //Account
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 240, 240, 240),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 7, top: 5),
                      child: Text(
                        'Account',
                        style: TextStyle(
                          color: AppColors.header,
                          fontFamily: 'Roboto-Medium',
                          fontSize: 14,
                        ),
                      ),
                    ),

                    //Change password
                    CategoryFuncUserProfile(
                      onTap: () =>
                          _navigatorFunc(context, const ChangePassword()),
                      icon: Icons.change_circle_outlined,
                      label: 'Change password',
                    ),

                    //Log out
                    CategoryFuncUserProfile(
                      onTap: _logout,
                      icon: Icons.logout,
                      label: 'Log out',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7),
              //Help
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 240, 240, 240),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 7, top: 5),
                      child: Text(
                        'Help & Support',
                        style: TextStyle(
                          color: AppColors.header,
                          fontFamily: 'Roboto-Medium',
                          fontSize: 14,
                        ),
                      ),
                    ),

                    //About TradeUp App
                    CategoryFuncUserProfile(
                      onTap: () => _navigatorFunc(context, AboutUs()),
                      icon: Icons.info_outline_rounded,
                      label: 'About us',
                    ),
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
