import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tradeupapp/screens/main_app/profile/edit_profile/controller/edit_profile_controller.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';
import 'package:tradeupapp/widgets/general/general_custom_dialog.dart';
import 'package:tradeupapp/widgets/general/general_loading_screen.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/edit_profile_widgets/edit_profile_button_submit.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/edit_profile_widgets/edit_profile_tagname_custom_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/edit_profile_widgets/edit_profile_text_field.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/edit_profile_widgets/edit_profile_upload_image_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final editProfileController = Get.put(EditProfileController());

  @override
  void initState() {
    super.initState();
    editProfileController.loadUser();
  }

  @override
  Widget build(BuildContext context) {
    editProfileController.context = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (editProfileController.isLoading.value) {
          return LoadingScreenGeneral(message: "Loading data...");
        }
        return SafeArea(
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
                        //Button back priveous page
                        BackButtonCustomGeneral(),

                        const SizedBox(height: 40),

                        //Upload image user
                        UploadImageEditProfile(
                          imageUrl: editProfileController.imageURL.value,
                          onPressedUploadImage: () {
                            editProfileController.showBottomSheet(context);
                          },
                          image: editProfileController.imageFile.value,
                        ),

                        SizedBox(height: 10),
                        //Tag name
                        TagNameCustomEditProfile(
                          controller: editProfileController.tagNameController,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //Text Input
                //Your name
                TextFieldEditProfile(
                  controller: editProfileController.fullnameController,
                  label: 'Fullname',
                  hintText: 'Enter your name...',
                ),
                //Phonenumber
                TextFieldEditProfile(
                  controller: editProfileController.phoneNumberController,
                  label: 'Phone number',
                  hintText: 'Enter your phone number...',
                  textInputType: TextInputType.phone,
                ),
                //Email
                TextFieldEditProfile(
                  controller: editProfileController.emailController,
                  label: 'Email address',
                  hintText: '',
                  enabled: false,
                  textInputType: TextInputType.emailAddress,
                ),

                //Location
                TextFieldEditProfile(
                  controller: editProfileController.addressController,
                  label: 'Address & Location',
                  hintText: 'Enter your address...',
                  suffixIcon: Icons.location_on,
                  onIconPressed: () {
                    editProfileController.getCurrentAddress();
                  },
                ),

                //Bio
                TextFieldEditProfile(
                  controller: editProfileController.bioController,
                  label: 'Bio',
                  hintText: 'Something...',
                ),

                //Button Cofirm
                ButtonSubmitEditProfile(
                  onPressed: () {
                    CustomDialogGeneral.show(
                      context,
                      'Confirm Update',
                      'Are you sure you want to update your profile information? These changes will be saved and visible to others.',
                      () => editProfileController.updateProfileUser(),
                      numberOfButton: 2,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
