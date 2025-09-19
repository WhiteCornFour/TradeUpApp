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
import 'package:tradeupapp/firebase/notification_service.dart';
import 'package:tradeupapp/models/message_modal.dart';
import 'package:tradeupapp/models/notification_model.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/models/user_model.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class MessageController extends GetxController {
  final messageController = TextEditingController();
  final Rxn<UserModel> user = Rxn<UserModel>();
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

  //Khai báo biến database
  final ns = NotificationService();

  ProductModel? product;

  String? idOtherUser;
  String? idChatRoom;
  MessageController({this.idOtherUser, this.idChatRoom});

  @override
  void onInit() async {
    user.value = await db.fetchUserModelById(idOtherUser!);

    //Kiểm tra nếu thông tin của người dùng là null thì ẩn lun phòng
    if (user.value == null) {
      handleDeleteChatRoom();
      SnackbarHelperGeneral.showCustomSnackBar(
        'Unable to open the chat room because the other user'
        's information is no longer available.',
        backgroundColor: Colors.red,
      );
    }
     _fetchAllMessages();
    super.onInit();
  }

  void _fetchAllMessages() {
    if (idChatRoom!.isEmpty) {
      // ignore: avoid_print
      print('Id Chat room is Empty!');
      return;
    }
    isLoading.value = true;
    FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(idChatRoom)
        .collection('messages')
        .where(
          Filter.or(
            Filter('status', isEqualTo: 0),
            Filter('status', isEqualTo: 2),
          ),
        )
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
            // ignore: avoid_print
            print("Error: $e");
            isLoading.value = false;
          },
        );
  }

  void handleDeleteChatRoom() {
    DatabaseService().updateStatusRoom(idChatRoom!, 1);
    Get.back();
  }

  void handleBlockChatRoom() {
    DatabaseService().updateStatusRoom(idChatRoom!, 2);
    Get.back();
  }

  //Thêm Notification khi người dùng gửi Message
  Future<void> addSendMessageNotification({
    required String receiverId,
    required String senderId,
  }) async {
    try {
      //1. Kiểm tra trong vòng 1 tiếng có thông báo chưa => nếu có thì bỏ qua
      final alreadyExists = await db.hasRecentMessageNotification(
        receiverId: receiverId,
        senderId: senderId,
      );

      if (alreadyExists) {
        // ignore: avoid_print
        print("Skip creating notification, already exists within 1h");
        return;
      }

      //2. Tạo object Notification và lưu vào Firestore
      final notification = NotificationModel(
        targetUserId: receiverId,
        actorUserId: senderId,
        productId: null,
        offerId: null,
        createdAt: Timestamp.now(),
        type: 0,
        isRead: 0, 
        message: "sent you a message.",
      );

      await db.addNotification(notification);

      //3. Lấy token của người nhận
      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(receiverId)
          .get();

      if (!userDoc.exists) {
        // ignore: avoid_print
        print("Receiver user not found!");
        return;
      }

      final tokens = List<String>.from(userDoc.data()?["fcmTokens"] ?? []);
      if (tokens.isEmpty) {
        // ignore: avoid_print
        print("Receiver has no FCM tokens!");
        return;
      }

      //4. Lấy thêm thông tin để hiển thị thông báo rõ ràng
      final actorDoc = await db.fetchUserModelById(senderId);
      final actorName = actorDoc?.fullName ?? 'Someone';

      //5. Gửi thông báo FCM cho tất cả token
      for (final token in tokens) {
        await ns.sendPushNotification(
          token: token,
          title: "New Message",
          body: "$actorName sent you a message.",
        );
      }
// ignore: avoid_print
      print("Message notification created successfully!");
    } catch (e) {
      // ignore: avoid_print
      print("Error addSendMessageNotification: $e");
    }
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
      await DatabaseService().addNewMessage(message.toJson(), idChatRoom!);

      await addSendMessageNotification(
        receiverId: idOtherUser!,
        senderId: idCurrentUser,
      );

      isLoadingButton.value = false;
    } catch (e) {
      // ignore: avoid_print
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
      // ignore: avoid_print
      print('Upload failed _uploadToCloudinary: ${response.statusCode}');
      return null;
    }
  }

  //Hàm xử lý xóa delete khi người dùng nhấn giữ
  void handleDeleteMessage(String idMessage, String senderID) {
    //Không cho xóa tin nhắn của người khác
    if (senderID != idCurrentUser) {
      SnackbarHelperGeneral.showCustomSnackBar(
        "You cannot delete the other user's message",
        backgroundColor: Colors.orange,
        seconds: 1,
      );
      return;
    }
    if (idMessage.isEmpty) return;
    DatabaseService().updateStatusMessage(idMessage, idChatRoom!);
  }

  //Hàm xử lý khi người dùng share product thông qua message
  void handleSendProduct(String idProducts, String idChatRoom) async {
    try {
      isLoadingButton.value = true;

      final message = MessageModal(
        content: idProducts,
        imageUrl: '',
        idSender: idCurrentUser,
        status: 2,
        timestamp: Timestamp.now(),
      );

      // Gửi message lên Firestore
      await DatabaseService().addNewMessage(
        message.toJson(),
        idChatRoom,
        lastMessage: "📦 Sent a product",
      );
      isLoadingButton.value = false;
      SnackbarHelperGeneral.showCustomSnackBar(
        'Sent product successfully!',
        backgroundColor: Colors.green,
      );
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoadingButton.value = false;
    }
  }

  void handleGetDataProductById(String idProduct) async {
    final data = await db.getProductById(idProduct);
    if (data != null) {
      product = data;
    }
  }
}
