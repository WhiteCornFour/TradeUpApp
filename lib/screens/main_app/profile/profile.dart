import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/profile/about_us/about_us.dart';
import 'package:tradeupapp/screens/main_app/profile/change_password/change_password.dart';
import 'package:tradeupapp/screens/main_app/profile/controller/profile_controller.dart';
import 'package:tradeupapp/screens/main_app/profile/report/report.dart';
import 'package:tradeupapp/widgets/general/general_custom_dialog.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/user_profile_appbar_custom_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/user_profile_business_mode_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/user_profile_category_func_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/user_profile_category_function_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.loadUser();
  }

  void _handleBusinessMode(bool value) {
    if (value) {
      CustomDialogGeneral.show(
        context,
        'Business Mode Enabled',
        'You are now in Business Mode.\nYour profile is visible to other users as a seller.',
        () {
          profileController.updateUserRole(2);
          SnackbarHelperGeneral.showCustomSnackBar(
            'You are now in Business Mode',
            backgroundColor: Colors.green,
          );
        },
        numberOfButton: 2,
      );
    } else {
      CustomDialogGeneral.show(
        context,
        'Business Mode Disabled',
        'You have exited Business Mode.',
        () {
          profileController.updateUserRole(1);
          SnackbarHelperGeneral.showCustomSnackBar(
            'You have exited Business Mode',
            backgroundColor: Colors.red,
          );
        },
        numberOfButton: 2,
        image: 'warning.jpg',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    profileController.context = context;
    return Obx(() {
      if (profileController.isLoading.value) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.background,
              color: AppColors.text,
            ),
          ),
        );
      }

      if (profileController.user.value == null) {
        return const Scaffold(
          body: Center(
            child: Text(
              'Cannot load user data!',
              style: TextStyle(
                color: AppColors.header,
                fontFamily: 'Roboto-Black',
                fontSize: 20,
              ),
            ),
          ),
        );
      }

      final user = profileController.user.value!;

      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppbarCustomUserProfile(
            fullName: user.fullName,
            address: user.address,
            imageURL: user.avtURL,
            onEditProfile: () {
              profileController.loadUser();
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                CategoryFuncProfile(
                  title: 'Business',
                  children: [
                    Obx(
                      () => BusinessModeUserProfile(
                        label: 'Business mode',
                        icon: Icons.business_center_outlined,
                        value: profileController.isBusinessMode.value,
                        onChanged: _handleBusinessMode,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                // Activity Section
                CategoryFuncProfile(
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
                      onTap: () =>
                          profileController.navigatorFunc(const Report()),
                      icon: Icons.report_outlined,
                      label: 'Report',
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                // Account Section
                CategoryFuncProfile(
                  title: 'Account',
                  children: [
                    CategoryFuncUserProfile(
                      onTap: () => profileController.navigatorFunc(
                        const ChangePassword(),
                      ),
                      icon: Icons.change_circle_outlined,
                      label: 'Change password',
                    ),
                    CategoryFuncUserProfile(
                      onTap: profileController.handleLogout,
                      icon: Icons.logout,
                      label: 'Log out',
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                // Help Section
                CategoryFuncProfile(
                  title: 'Help & Support',
                  children: [
                    CategoryFuncUserProfile(
                      onTap: () =>
                          profileController.navigatorFunc(const AboutUs()),
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
    });
  }
}
