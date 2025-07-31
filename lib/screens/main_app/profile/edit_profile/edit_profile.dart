import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/user_model.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';
import 'package:tradeupapp/widgets/general/general_custom_dialog.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/edit_profile_widgets/edit_profile_button_submit.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/edit_profile_widgets/edit_profile_tagname_custom_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/edit_profile_widgets/edit_profile_text_field.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/edit_profile_widgets/edit_profile_upload_image_widget.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _tagName = TextEditingController();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  File? image;
  String? imageURL;

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  @override
  void dispose() {
    super.dispose();
    _tagName.dispose();
    _fullname.dispose();
    _phoneNumber.dispose();
    _email.dispose();
    _address.dispose();
    _bio.dispose();
  }

  void getDataUser() async {
    final userData = await DatabaseService().loadCurrentUser();
    if (userData != null) {
      final user = UserModal.fromMap(userData);
      if (user.tagName == null) {
        _tagName.text =
            '@user${DateTime.now().day}${DateTime.now().month}${DateTime.now().millisecond}${DateTime.now().microsecond}';
      } else {
        _tagName.text = user.tagName!;
      }
      setState(() {
        imageURL = user.avtURL;
      });

      //print('imageURL from firebase: $imageURL');
      _fullname.text = user.fullName.toString();
      _phoneNumber.text = user.phoneNumber.toString();
      _email.text = user.email.toString();
      _address.text = user.address.toString();
      _bio.text = user.bio.toString();
    }
  }

  //Lấy location hiện tại của user
  Future<void> getCurrentAddress() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    LocationData locationData = await location.getLocation();

    List<Placemark> placemarks = await placemarkFromCoordinates(
      locationData.latitude!,
      locationData.longitude!,
    );

    Placemark place = placemarks.first;
    //gán vào text field
    _address.text = "${place.street}, ${place.locality}, ${place.country}"
        .toString();
  }

  //Hàm chọn ảnh từ camera
  Future<void> _pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      //print("📷 Image picked path: ${pickedFile.path}");
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  //Hàm chọn ảnh từ gallery
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      //print("📷 Image picked path: ${pickedFile.path}");
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  //show bottom sheet để lựa chọn ảnh từ gallery hay camera
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                    color: AppColors.header,
                  ),
                  title: const Text(
                    'Take a photo with Camera',
                    style: TextStyle(
                      color: AppColors.header,
                      fontFamily: 'Roboto-Regular',
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    // TODO: Gọi hàm chọn ảnh từ camera
                    _pickImageFromCamera();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: AppColors.header,
                  ),
                  title: const Text(
                    'Choose Photo from Gallery',
                    style: TextStyle(
                      color: AppColors.header,
                      fontFamily: 'Roboto-Regular',
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    // TODO: Gọi hàm chọn ảnh từ gallery
                    _pickImageFromGallery();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.close, color: AppColors.header),
                  title: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColors.header,
                      fontFamily: 'Roboto-Regular',
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //kiểm tra thông tin trước khi update
  String? validateUserInfoBeforeUpdate() {
    // Check avatar image (if required)
    // if (image == null) {
    //   return "Please select a profile image.";
    // }
    //check tagname
    if (_tagName.text.trim().isEmpty) {
      return 'Tag name cannot be empty.';
    }
    // Check tagname length
    if (_tagName.text.length > 16) {
      return "Tagname cannot exceed 16 characters.";
    }
    // Check full name
    if (_fullname.text.trim().isEmpty) {
      return "Full name cannot be empty.";
    }

    // Check phone number format
    final phoneRegex = RegExp(r'^(0|\+84)[0-9]{9}$');
    if (!phoneRegex.hasMatch(_phoneNumber.text.trim())) {
      return "Invalid phone number format.";
    }

    // Check address
    if (_address.text.trim().isEmpty) {
      return "Address cannot be empty.";
    }

    // Check bio length
    if (_bio.text.length > 200) {
      return "Bio cannot exceed 200 characters.";
    }

    return null; // All fields are valid
  }

  //Hàm upload ảnh lên Cloudinary và lấy URL
  Future<String?> uploadToCloudinary(File imageFile) async {
    const cloudName = 'dhmzkwjlf';
    const uploadPreset = 'flutter_upload';

    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final resStr = await response.stream.bytesToString();
      final resData = json.decode(resStr);
      return resData['secure_url']; // link ảnh
    } else {
      print('Upload failed: ${response.statusCode}');
      return null;
    }
  }

  //Hàm xử lý update profile user
  Future<void> _updateProfileUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    // Validate thông tin
    String? validationMessage = validateUserInfoBeforeUpdate();
    if (validationMessage != null) {
      SnackbarHelperGeneral.showCustomSnackBar(context, validationMessage);
      return;
    }

    // Lấy thông tin user hiện tại từ Firestore
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();

    final currentUserModel = UserModal.fromMap(userDoc.data()!);

    // Nếu có ảnh mới thì upload, còn không thì dùng avtURL cũ
    String? url;
    if (image != null) {
      url = await uploadToCloudinary(image!);
      if (url == null) {
        SnackbarHelperGeneral.showCustomSnackBar(
          context,
          'Failed to upload image. Please try again.',
          backgroundColor: Colors.red,
        );
        return;
      }
    }

    // Tạo user mới để cập nhật
    final updatedUser = UserModal(
      email: _email.text.trim(),
      password: '', // không cập nhật mật khẩu ở đây
      fullName: _fullname.text.trim(),
      avtURL: url ?? currentUserModel.avtURL,
      bio: _bio.text.trim(),
      address: _address.text.trim(),
      phoneNumber: _phoneNumber.text.trim(),
      tagName: _tagName.text.trim(),
      role: currentUserModel.role, // giữ nguyên role cũ
      rating: currentUserModel.rating, // nếu cần giữ điểm đánh giá
    );

    // Cập nhật Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .update(updatedUser.toMap());

    //Cập nhật lại ảnh đại diện
    setState(() {
      imageURL = updatedUser.avtURL;
    });
    // Thông báo
    SnackbarHelperGeneral.showCustomSnackBar(
      context,
      'Your profile has been updated successfully.',
      backgroundColor: Colors.green,
    );
  }

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
                      //Button back priveous page
                      BackButtonCustomGeneral(),

                      const SizedBox(height: 40),
                      //Upload image user
                      UploadImageEditProfile(
                        imageUrl: imageURL,
                        onPressedUploadImage: () => _showBottomSheet(context),
                        image: image,
                      ),

                      SizedBox(height: 10),
                      //Tag name
                      TagNameCustomEditProfile(controller: _tagName),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              //Text Input
              //Your name
              TextFieldEditProfile(
                controller: _fullname,
                label: 'Fullname',
                hintText: 'Enter your name...',
              ),
              //Phonenumber
              TextFieldEditProfile(
                controller: _phoneNumber,
                label: 'Phone number',
                hintText: 'Enter your phone number...',
                textInputType: TextInputType.phone,
              ),
              //Email
              TextFieldEditProfile(
                controller: _email,
                label: 'Email address',
                hintText: '',
                enabled: false,
                textInputType: TextInputType.emailAddress,
              ),
              //Location
              TextFieldEditProfile(
                controller: _address,
                label: 'Address & Location',
                hintText: 'Enter your address...',
                suffixIcon: Icons.location_on,
                onIconPressed: () {
                  getCurrentAddress();
                },
              ),
              //Bio
              TextFieldEditProfile(
                controller: _bio,
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
                    _updateProfileUser,
                    numberOfButton: 2,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
