import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/chat_room_model.dart';

class ChatRoomController extends GetxController {
  final searchController = TextEditingController();
  var chatRooms = <ChatRoomModel>[].obs;
  final isLoading = false.obs;
  //Lưu ds lọc
  var filteredChatRooms = <ChatRoomModel>[].obs;
  //Khai báo biến database
  final db = DatabaseService();
  @override
  void onInit() {
    super.onInit();
    _listenToChatRooms();
  }

  //load ds cac chat room cua nguoi dung realtime
  void _listenToChatRooms() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
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
            print("Error: $e");
            isLoading.value = false;
          },
        );
  }

  void filterChatRoomsByName(String query) {
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
  }
}
