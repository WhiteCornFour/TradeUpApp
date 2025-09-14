import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/chat_room_model.dart';
import 'package:tradeupapp/screens/main_app/chat/message.dart';
import 'package:tradeupapp/widgets/general/general_custom_dialog.dart';

class ChatRoomController extends GetxController {
  //Có thể gọi ra controller ở bất kỳ đâu mà ko cần gọi lại
  static ChatRoomController get instance => Get.find();

  final uid = FirebaseAuth.instance.currentUser?.uid;
  final searchController = TextEditingController();
  var chatRooms = <ChatRoomModel>[].obs;
  final isLoading = false.obs;
  //Lưu ds lọc
  var filteredChatRooms = <ChatRoomModel>[].obs;
  //Khai báo biến database
  final db = DatabaseService();

  BuildContext? context;
  @override
  void onInit() {
    super.onInit();
    listenToChatRooms();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  //load ds cac chat room cua nguoi dung realtime
  Future<void> listenToChatRooms() async {
    if (uid == null) return;

    isLoading.value = true;

    FirebaseFirestore.instance
        .collection('chatRoom')
        .where(
          Filter.and(
            Filter('status', isEqualTo: 0),
            Filter.or(
              Filter('idUser1', isEqualTo: uid),
              Filter('idUser2', isEqualTo: uid),
            ),
          ),
        )
        .snapshots()
        .listen(
          (snapshot) async {
            List<ChatRoomModel> rooms = snapshot.docs.map((doc) {
              final chat = ChatRoomModel.fromJson(doc.data());
              chat.idChatRoom = doc.id; // Gán ID của document
              return chat;
            }).toList();

            // Lấy thông tin người còn lại trong từng room
            for (var room in rooms) {
              final otherUserId = room.idUser1 == uid
                  ? room.idUser2
                  : room.idUser1;
              final user = await db.fetchUserModelById(otherUserId);
              if (user != null) {
                room.otherUserName = user.fullName;
                room.otherUserAvatar = user.avtURL;
              }
            }

            chatRooms.value = rooms;
            //Hiển thị những người liên lạc gần nhất thông qua lastTime
            chatRooms.sort((a, b) => b.lastTime.compareTo(a.lastTime));
            filteredChatRooms.value = rooms;
            isLoading.value = false;
          },
          onError: (e) {
            // ignore: avoid_print
            print("Error _listenToChatRooms: $e");
            isLoading.value = false;
          },
        );
  }

  void filterChatRoomsByNameAndTagname(String query) async {
    final lowerQuery = query.toLowerCase();

    if (lowerQuery.isEmpty) {
      filteredChatRooms.value = chatRooms;
      return;
    }

    filteredChatRooms.value = chatRooms
        .where(
          (chat) =>
              chat.otherUserName?.toLowerCase().contains(lowerQuery) ?? false,
        )
        .toList();

    //Thuc hien cung luc tim kiem theo tagname cua user
    _filterChatRoomByTagName(query);
  }

  void _filterChatRoomByTagName(String query) async {
    if (query.isEmpty) {
      filteredChatRooms.value = chatRooms;
      return;
    }

    final user = await db.searchUserByTagName(query);

    if (user != null && user.userId != uid) {
      final newRoom = ChatRoomModel(
        idUser1: uid!,
        idUser2: user.userId!,
        lastMessage: "Let's start the conversation",
        lastTime: Timestamp.now(),
        status: 0,
        otherUserName: user.fullName,
        otherUserAvatar: user.avtURL,
      );

      // Gộp chatRooms đã filter với newRoom → loại bỏ trùng
      final merged = {
        for (var room in [...filteredChatRooms, newRoom])
          room.idUser1 == uid ? room.idUser2 : room.idUser1: room,
      };

      filteredChatRooms.value = merged.values.toList();
    }
  }

  void handleSendMessage(String idUser) async {
    searchController.text = '';
    String? result = await db.checkChatRoomStatus(uid!, idUser);

    if (result == "Block") {
      // Hiển thị thông báo và dừng
      CustomDialogGeneral.show(
        context!,
        'Messaging blocked',
        'You have blocked this user. Unblock them to continue chatting.',
        () async {
          String? newId = await db.createNewChatRoom(uid!, idUser);
          if (newId != null) {
            // ignore: avoid_print
            print('Created new chat room with ID: $newId');
            Get.to(Message(idOtherUser: idUser, idChatRoom: newId));
          }
        },
        image: 'warning.jpg',
        numberOfButton: 2,
        textButton1: 'Yes',
        textButton2: 'No',
      );
      return;
    }

    if (result != null) {
      // Tồn tại phòng và không bị block
      // ignore: avoid_print
      print('Chat room exists with ID: $result');
      db.updateStatusRoom(result, 0);
      Get.to(Message(idOtherUser: idUser, idChatRoom: result));
    } else {
      // Không tồn tại phòng → tạo mới
      String? newId = await db.createNewChatRoom(uid!, idUser);
      if (newId != null) {
        // ignore: avoid_print
        print('Created new chat room with ID: $newId');
        Get.to(Message(idOtherUser: idUser, idChatRoom: newId));
      }
    }
  }
}
