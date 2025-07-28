import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/report_model.dart';
import 'package:tradeupapp/utils/back_button.dart';
import 'package:tradeupapp/utils/custom_dialog.dart';
import 'package:tradeupapp/utils/snackbar_helper.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/report_widgets/report_submit_button_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/report_widgets/report_text_field_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/report_widgets/report_upload_list_image_widget.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final TextEditingController _contentFeedBack = TextEditingController();
  final TextEditingController _tagnameTarget = TextEditingController();
  List<File> imageList = [];
  bool _isSubmitting = false;
  @override
  void dispose() {
    _contentFeedBack.dispose();
    _tagnameTarget.dispose();
    super.dispose();
  }

  void _handleSubmitReport() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (_contentFeedBack.text.isEmpty) {
      SnackbarHelper.showCustomSnackBar(
        context,
        'Enter the details of what you want to report!',
        backgroundColor: Colors.red,
      );
      return;
    }
    setState(() => _isSubmitting = true);
    //Gọi hàm upload ảnh lên cloudinary
    try {
      List<String> urlImageList = [];
      if (imageList.isNotEmpty) {
        for (var imageFile in imageList) {
          String? url;
          url = await uploadToCloudinary(imageFile);
          if (url == null) {
            SnackbarHelper.showCustomSnackBar(
              context,
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
        content: _contentFeedBack.text,
        tagnameToReport: _tagnameTarget.text.isEmpty
            ? 'Unknown'
            : _tagnameTarget.text,
        imageList: urlImageList,
        status: 0,
        createdAt:
            '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}-${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
      );
      //Thêm report lên firebase
      await FirebaseFirestore.instance
          .collection('reports')
          .add(reportData.toMap());
      // Clear UI
      setState(() {
        _contentFeedBack.clear();
        _tagnameTarget.clear();
        imageList.clear();
        _isSubmitting = false;
      });
      SnackbarHelper.showCustomSnackBar(
        context,
        'Your report has been submitted successfully.',
        backgroundColor: Colors.green,
      );
    } catch (e) {
      setState(() => _isSubmitting = false);
      SnackbarHelper.showCustomSnackBar(
        context,
        'Something went wrong. Please try again.',
        backgroundColor: Colors.red,
      );
    }
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

  //Hàm chọn ảnh từ gallery
  Future<void> _pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        imageList.add(File(pickedImage.path));
      });
    }
  }

  //Hàm chọn ảnh từ camera
  Future<void> _pickImageFromCamera() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      setState(() {
        imageList.add(File(pickedImage.path));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButtonCustom(),
                    const Text(
                      'Report',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Center(
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/report.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Something’s Not Right? Let Us Know',
                  style: TextStyle(
                    color: AppColors.header,
                    fontSize: 20,
                    fontFamily: 'Roboto-Black',
                  ),
                ),
                Text(
                  'Report this user if you notice any suspicious or harmful behavior.',
                  style: TextStyle(
                    color: AppColors.header,
                    fontSize: 15,
                    fontFamily: 'Roboto-Medium',
                  ),
                ),
                SizedBox(height: 20),
                TextFieldReport(
                  label: 'Enter your feedback...',
                  controller: _contentFeedBack,
                  maxLength: 250,
                  maxLines: 10,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tagname to Report (if any)',
                        style: TextStyle(
                          color: AppColors.header,
                          fontSize: 17,
                          fontFamily: 'Roboto-Medium',
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFieldReport(
                        label: 'Tagname target...',
                        controller: _tagnameTarget,
                        maxLength: 16,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                UploadImageReport(
                  onPressed: () => _showBottomSheet(context),
                  imageList: imageList,
                ),
                SizedBox(height: 20),
                ButtomSubmitReport(
                  onPressed: () {
                    CustomDialog.show(
                      context,
                      'Confirm Report Submission',
                      'Do you want to proceed with submitting this report?\nOur team will review it as soon as possible.',
                      () {
                        _handleSubmitReport();
                      },
                      numberOfButton: 2,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
