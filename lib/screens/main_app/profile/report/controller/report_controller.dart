import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/report_model.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class ReportController extends GetxController {
  final contentFeedBackController = TextEditingController();
  final tagnameTargetController = TextEditingController();
  RxList<File> imageList = <File>[].obs;
  late final BuildContext context;

  @override
  void onClose() {
    contentFeedBackController.dispose();
    tagnameTargetController.dispose();
    super.onClose();
  }

  //Thêm hình ảnh vào image list và theo dõi số image đã upload
  void addNewImageToImageList(File image) {
    if (!imageList.any((file) => file.path == image.path)) {
      imageList.add(image);
    }
  }

  // //Hàm upload ảnh lên Cloudinary và lấy URL
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
      SnackbarHelperGeneral.showCustomSnackBar(
        // ignore: use_build_context_synchronously
        
        'Upload failed: ${response.statusCode}',
        backgroundColor: Colors.red,
      );
      return null;
    }
  }

  //Hàm thêm report mới vào firbase
  void handleSubmitReport(BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (contentFeedBackController.text.isEmpty) {
      SnackbarHelperGeneral.showCustomSnackBar(
        
        'Enter the details of what you want to report!',
        backgroundColor: Colors.red,
      );
      return;
    }
    //Gọi hàm upload ảnh lên cloudinary
    try {
      List<String> urlImageList = [];
      if (imageList.isNotEmpty) {
        for (var imageFile in imageList) {
          String? url;
          url = await uploadToCloudinary(imageFile);
          if (url == null) {
            SnackbarHelperGeneral.showCustomSnackBar(
              
              'Failed to upload image. Please try again.',
              backgroundColor: Colors.red,
            );
            return;
          } else {
            urlImageList.add(url);
          }
        }
      }
      //Chuẩn bị Report modal để add report lên firebase
      final reportData = ReportModel(
        idUserReported: currentUser!.uid,
        content: contentFeedBackController.text,
        tagnameToReport: tagnameTargetController.text.isEmpty
            ? 'Unknown'
            : tagnameTargetController.text,
        imageList: urlImageList,
        status: 0,
        createdAt: Timestamp.now().toString(),
      );
      //Thêm report lên firebase
      await FirebaseFirestore.instance
          .collection('reports')
          .add(reportData.toMap());
      // Clear UI
      _clearTextField();
      SnackbarHelperGeneral.showCustomSnackBar(
        
        'Your report has been submitted successfully.',
        backgroundColor: Colors.green,
      );
    } catch (e) {
      SnackbarHelperGeneral.showCustomSnackBar(
        
        'Something went wrong. Please try again.',
        backgroundColor: Colors.red,
      );
    }
  }

  //show bottom sheet để lựa chọn ảnh từ gallery hay camera
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
                    'Cancle',
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

  //Hàm chọn ảnh từ gallery
  Future<void> _pickImageFromGallery() async {
    if (imageList.length > 4) {
      SnackbarHelperGeneral.showCustomSnackBar(
        
        'Only 5 images are allowed for upload!',
        backgroundColor: Colors.orange,
      );
    } else {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedImage != null) {
        // setState(() {
        //   imageList.add(File(pickedImage.path));
        // });
        addNewImageToImageList(File(pickedImage.path));
      }
    }
  }

  //Hàm chọn ảnh từ camera
  Future<void> _pickImageFromCamera() async {
    if (imageList.length > 4) {
      SnackbarHelperGeneral.showCustomSnackBar(
        
        'Only 5 images are allowed for upload!',
        backgroundColor: Colors.orange,
      );
    } else {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (pickedImage != null) {
        // setState(() {
        //   imageList.add(File(pickedImage.path));
        // });
        addNewImageToImageList(File(pickedImage.path));
      }
    }
  }

  //Hàm clear textField sau khi thành công
  void _clearTextField() {
    contentFeedBackController.clear();
    tagnameTargetController.clear();
    imageList.clear();
  }
}
