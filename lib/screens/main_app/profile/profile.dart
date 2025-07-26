import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/user_model.dart';
import 'package:tradeupapp/screens/authentication/login.dart';
import 'package:tradeupapp/screens/main_app/profile/about_us/about_us.dart';
import 'package:tradeupapp/screens/main_app/profile/change_password/change_password.dart';
import 'package:tradeupapp/screens/main_app/profile/report/report.dart';
import 'package:tradeupapp/utils/custom_dialog.dart';
import 'package:tradeupapp/utils/snackbar_helper.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/user_profile_appbar_custom_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/user_profile_business_mode_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/user_profile_category_function_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isBusinessMode = false;

  Future<UserModal?> _loadUserFuture() async {
    final userData = await DatabaseService().loadCurrentUser();
    if (userData != null) {
      return UserModal.fromMap(userData);
    }
    return null;
  }

  void _logout() async {
    try {
      //Sign Out bình thường
      await authServices.value.signOut();
      //Sign Out Google Account
      await GoogleSignIn().signOut();
      Get.offAll(() => Login());
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  void _navigatorFunc(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  void _handleBusinessMode(bool value) async {
    setState(() {
      isBusinessMode = value;
    });
    if (isBusinessMode) {
      CustomDialog.show(
        context,
        'Business Mode Enabled',
        'You are now in Business Mode.\nYour profile is visible to other users as a seller, and you can start managing your products and offers.',
        numberOfButton: 2,
        //Thực hiện hành động cập nhật lại role cho người dùng
        () {
          updateRoleUser(2);
          SnackbarHelper.showCustomSnackBar(
            context,
            'You are now in Business Mode',
            backgroundColor: Colors.green,
          );
          setState(() {
            isBusinessMode = true;
          });
        },
        //Khi dùng hủy thì đặt lại value của business là false
        () {
          setState(() {
            isBusinessMode = false;
          });
        },
      );
    } else {
      CustomDialog.show(
        context,
        'Business Mode Disabled',
        'You have exited Business Mode.\nYour seller profile is hidden, and you won’t receive business-related notifications.',
        image: 'warning.jpg',
        numberOfButton: 2,
        //Thực hiện hành động cập nhật lại role cho người dùng
        () {
          updateRoleUser(1);
          SnackbarHelper.showCustomSnackBar(
            context,
            'You have exited Business Mode',
            backgroundColor: Colors.red,
          );
          setState(() {
            isBusinessMode = false;
          });
        },
        //Khi dùng hủy thì đặt lại value của business là true
        () {
          setState(() {
            isBusinessMode = true;
          });
        },
      );
    }
  }

  //Hàm cập nhật role của user lên firebase
  Future<void> updateRoleUser(int? role) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) throw Exception("User not logged in");

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({'role': role});
    } catch (e) {
      print("❌ Failed to update role: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModal?>(
      future: _loadUserFuture(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.background,
                color: AppColors.text,
              ),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text('Cannot load user data!')),
          );
        }

        final user = snapshot.data!;
        //Kiểm tra business mode có bật hay không?
        isBusinessMode = user.role == 1 ? false : true;

        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppbarCustomUserProfile(
              fullName: user.fullName,
              address: user.address,
              imageURL: user.avtURL,
              onEditProfile: () {
                setState(() {}); // Gọi lại build để FutureBuilder reload
              },
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // Business Section
                  _buildSection(
                    title: 'Business',
                    children: [
                      //Business Mode
                      BusinessModeUserProfile(
                        label: 'Business mode',
                        icon: Icons.business_center_outlined,
                        value: isBusinessMode,
                        onChanged: (value) {
                          _handleBusinessMode(value);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  // Activity Section
                  _buildSection(
                    title: 'Activity',
                    children: [
                      CategoryFuncUserProfile(
                        onTap: () {},
                        icon: Icons.history,
                        label: 'Buy history',
                      ),
                      CategoryFuncUserProfile(
                        onTap: () {},
                        icon: Icons.history,
                        label: 'Sales history',
                      ),
                      CategoryFuncUserProfile(
                        onTap: () => _navigatorFunc(context, const Report()),
                        icon: Icons.report_outlined,
                        label: 'Report',
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  // Account Section
                  _buildSection(
                    title: 'Account',
                    children: [
                      CategoryFuncUserProfile(
                        onTap: () =>
                            _navigatorFunc(context, const ChangePassword()),
                        icon: Icons.change_circle_outlined,
                        label: 'Change password',
                      ),
                      CategoryFuncUserProfile(
                        onTap: _logout,
                        icon: Icons.logout,
                        label: 'Log out',
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  // Help Section
                  _buildSection(
                    title: 'Help & Support',
                    children: [
                      CategoryFuncUserProfile(
                        onTap: () => _navigatorFunc(context, const AboutUs()),
                        icon: Icons.info_outline_rounded,
                        label: 'About us',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Helper widget for each section
  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 7, top: 5),
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.header,
                fontFamily: 'Roboto-Medium',
                fontSize: 14,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
