import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/firebase/auth_service.dart';
import 'package:tradeupapp/firebase/database_service.dart';

import 'package:tradeupapp/models/message_modal.dart';
import 'package:tradeupapp/models/user_model.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class MessageController extends GetxController {
  final messageController = TextEditingController();
  final Rxn<UserModal> user = Rxn<UserModal>();
  final String idOtherUser;
  final String idChatRoom;
  RxList<MessageModal> messageList = <MessageModal>[].obs;
  final isLoading = false.obs;
  //Current user
  final idCurrentUser = AuthServices().currentUser!.uid;
  //Xử lý ảnh
  final imageFile = Rxn<File>();
  //isLoadingButton
  var isLoadingButton = false.obs;
  //Khai báo biến database
  final db = DatabaseService();

  MessageController({required this.idOtherUser, required this.idChatRoom});

  @override
  void onInit() async {
    user.value = await db.fetchUserModelById(idOtherUser);
    // _fetchUserModelById(idOtherUser);
    _fetchAllMessages();
    super.onInit();
  }

  // Future<void> _fetchUserModelById(String idUser) async {
  //   try {
  //     final docSnapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(idUser)
  //         .get();

  //     if (docSnapshot.exists) {
  //       user.value = UserModal.fromMap(docSnapshot.data()!);
  //     } else {
  //       print('User not found');
  //     }
  //   } catch (e) {
  //     print('Error fetching user: $e');
  //   }
  // }

  void _fetchAllMessages() {
    if (idChatRoom.isEmpty) {
      print('Id Chat room is Empty!');
      return;
    }
    isLoading.value = true;
    FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(idChatRoom)
        .collection('messages')
        .where('status', isEqualTo: 0)
        .snapshots()
        .listen(
          (event) async {
            messageList.value = event.docs.map((e) {
              final messages = MessageModal.fromJson(e.data());
              messages.idMessage = e.id;
              return messages;
            }).toList();

            messageList.sort((a, b) => a.timestamp.compareTo(b.timestamp));

            isLoading.value = false;
          },
          onError: (e) {
            print("Error: $e");
            isLoading.value = false;
          },
        );
  }

  void handleDeleteChatRoom() {
    DatabaseService().updateStatusRoom(idChatRoom, 1);
    Get.back();
  }

  void handleBlockChatRoom() {
    DatabaseService().updateStatusRoom(idChatRoom, 2);
    Get.back();
  }

  void handleSendMessage() async {
    var text = messageController.text.trim();

    if (text.isEmpty && imageFile.value == null) {
      SnackbarHelperGeneral.showCustomSnackBar(
        'Please enter your message!',
        backgroundColor: Colors.orange,
        seconds: 1,
      );
      return;
    }

    try {
      isLoadingButton.value = true;
      // Upload nếu có file
      String? imageURL;
      if (imageFile.value != null) {
        imageURL = await _uploadToCloudinary(imageFile.value!);
        text = 'Sent a photo';
        deleletImageFileSelected();
      }

      final message = MessageModal(
        content: text,
        imageUrl: imageURL ?? '',
        idSender: idCurrentUser,
        status: 0,
        timestamp: Timestamp.now(),
      );

      // Gửi message lên Firestore
      await DatabaseService().addNewMessage(message.toJson(), idChatRoom);
      isLoadingButton.value = false;
    } catch (e) {
      print('Error: $e');
    } finally {
      // Dọn dẹp controller sau khi gửi
      messageController.clear();
      isLoadingButton.value = false;
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

  void deleletImageFileSelected() {
    imageFile.value!.delete();
    imageFile.value = null;
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

  //Hàm xử lý xóa delete khi người dùng nhấn giữ
  void handleDeleteMessage(String idMessage) {
    if (idMessage.isEmpty) return;
    DatabaseService().updateStatusMessage(idMessage, idChatRoom);
  }
}
