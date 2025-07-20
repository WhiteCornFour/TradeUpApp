import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';
import 'package:tradeupapp/utils/back_button.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/edit_profile_widgets/edit_profile_button_submit.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/edit_profile_widgets/edit_profile_text_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: const Color.fromARGB(255, 243, 243, 243),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BackButtonCustom(),
                      const SizedBox(height: 40),
                      Center(
                        child: Stack(
                          children: [
                            // Avatar
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'lib/assets/images/logo.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                            ),

                            // Icon camera
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  // TODO: xử lý chọn ảnh mới
                                },
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: AppColors.header,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: AppColors.text,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Xử lý khi bấm nút
                          },
                          style: TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            padding: EdgeInsets
                                .zero, // Nếu bạn muốn không có padding thừa
                            minimumSize: Size(0, 0), // Đảm bảo nhỏ gọn
                            tapTargetSize: MaterialTapTargetSize
                                .shrinkWrap, // Bỏ vùng đệm tap mặc định
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'hoangnam04',
                                style: TextStyle(
                                  color: AppColors.header,
                                  fontSize: 17,
                                  fontFamily: 'Roboto-Regular',
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.edit,
                                color: AppColors.header,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              //Text Input
              //Your name
              TextFieldEditProfile(
                label: 'Fullname',
                hintText: 'Enter your name...',
                // suffixIcon: Icons.location_on,
                onIconPressed: () {
                  // Xử lý mở vị trí ở đây
                  print('Tapped location icon!');
                },
              ),
              //Phonenumber
              TextFieldEditProfile(
                label: 'Phone number',
                hintText: 'Enter your phone number...',
                textInputType: TextInputType.phone,
              ),
              //Email
              TextFieldEditProfile(
                label: 'Email address',
                hintText: '',
                enabled: false,
                textInputType: TextInputType.emailAddress,
              ),
              //Location
              TextFieldEditProfile(
                label: 'Address & Location',
                hintText: 'Enter your address...',
                suffixIcon: Icons.location_on,
                onIconPressed: () {},
              ),
              //Bio
              TextFieldEditProfile(label: 'Bio', hintText: 'Something...'),

              //Button Cofirm
              ButtonSubmitEditProfile(),
            ],
          ),
        ),
      ),
    );
  }
}
