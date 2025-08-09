import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/user_model.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class EditProfileController extends GetxController {
  final tagNameController = TextEditingController();
  final fullnameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final bioController = TextEditingController();

  var user = Rxn<UserModal>();
  final isLoading = false.obs;
  late BuildContext context;

  final imageFile = Rxn<File>(); // File ảnh mới
  final imageURL = ''.obs; // URL ảnh từ Firebase

  // Load dữ liệu người dùng
  Future<void> loadUser() async {
    isLoading.value = true;

    try {
      final data = await DatabaseService().fetchDataCurrentUser();
      if (data != null) {
        user.value = UserModal.fromMap(data);
      }

      var userData = user.value!;
      tagNameController.text = userData.tagName ?? '';
      fullnameController.text = userData.fullName ?? '';
      phoneNumberController.text = userData.phoneNumber ?? '';
      emailController.text = userData.email ?? '';
      addressController.text = userData.address ?? '';
      bioController.text = userData.bio ?? '';
      imageURL.value = userData.avtURL ?? '';
    } catch (e) {
      SnackbarHelperGeneral.showCustomSnackBar(
        'Error: $e',
        backgroundColor: Colors.red,
        seconds: 1,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Show bottom sheet chọn ảnh
  void showBottomSheet(BuildContext context) {
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

  // Chọn ảnh từ camera
  Future<void> _pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  // Chọn ảnh từ gallery
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  // Lấy địa chỉ hiện tại
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
    addressController.text =
        "${place.street}, ${place.locality}, ${place.country}";
  }

  // Kiểm tra dữ liệu nhập vào
  String? _validateUserInfoBeforeUpdate() {
    if (tagNameController.text.trim().isEmpty) {
      return 'Tag name cannot be empty.';
    }
    if (tagNameController.text.length > 16) {
      return "Tagname cannot exceed 16 characters.";
    }
    if (fullnameController.text.trim().isEmpty) {
      return "Full name cannot be empty.";
    }

    final phoneRegex = RegExp(r'^(0|\+84)[0-9]{9}$');
    if (!phoneRegex.hasMatch(phoneNumberController.text.trim())) {
      return "Invalid phone number format.";
    }

    if (addressController.text.trim().isEmpty) {
      return "Address cannot be empty.";
    }

    if (bioController.text.length > 200) {
      return "Bio cannot exceed 200 characters.";
    }

    return null;
  }

  // Upload ảnh lên Cloudinary
  Future<String?> _uploadToCloudinary(File imageFile) async {
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
      return resData['secure_url'];
    } else {
      print('Upload failed: ${response.statusCode}');
      return null;
    }
  }

  // Cập nhật thông tin người dùng
  Future<void> updateProfileUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    String? validationMessage = _validateUserInfoBeforeUpdate();
    if (validationMessage != null) {
      SnackbarHelperGeneral.showCustomSnackBar(validationMessage);
      return;
    }

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();

    final currentUserModel = UserModal.fromMap(userDoc.data()!);

    String? url;
    if (imageFile.value != null) {
      url = await _uploadToCloudinary(imageFile.value!);
      if (url == null) {
        SnackbarHelperGeneral.showCustomSnackBar(
          'Failed to upload image. Please try again.',
          backgroundColor: Colors.red,
        );
        return;
      }
    } else {
      url = currentUserModel.avtURL;
    }

    final updatedUser = UserModal(
      email: emailController.text.trim(),
      password: '',
      fullName: fullnameController.text.trim(),
      avtURL: url,
      bio: bioController.text.trim(),
      address: addressController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      tagName: tagNameController.text.trim(),
      role: currentUserModel.role,
      rating: currentUserModel.rating,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .update(updatedUser.toMap());

    loadUser();

    SnackbarHelperGeneral.showCustomSnackBar(
      'Your profile has been updated successfully.',
      backgroundColor: Colors.green,
    );
  }
}
