import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/chat/message.dart';
import 'package:tradeupapp/screens/main_app/chat/controllers/chat_room_controller.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/chat_room_app_bar_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/chat_room_item_user_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/chat_room_no_chat_found_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/chat_room_search_bar_widget.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _Chat();
}

class _Chat extends State<Chat> {
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  final chatController = Get.put(ChatRoomController());

  @override
  void initState() {
    super.initState();

    chatController.searchController.addListener(() {
      chatController.filterChatRoomsByName(
        chatController.searchController.text,
      );
    });
  }

  String _formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();

    // Lấy giờ:phút
    String hourMinute = DateFormat('HH:mm').format(dateTime);

    // Lấy ngày và tháng dạng "5 Th7"
    String day = dateTime.day.toString();
    String month = 'Th${dateTime.month}';

    return '$hourMinute $day $month';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBarChatRoom(),
      body: SafeArea(
        child: Column(
          children: [
            SearchBarChatRoom(
              onTap: () {},
              hintText: 'Looking for someone?',
              searchController: chatController.searchController,
            ),
            SizedBox(height: 10),

            Expanded(
              child: Obx(() {
                if (chatController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColors.background,
                      color: AppColors.text,
                    ),
                  );
                }

                if (chatController.chatRooms.isEmpty) {
                  return NoChatFoundChatRoom();
                }

                return ListView.builder(
                  itemCount: chatController.filteredChatRooms.length,
                  physics: BouncingScrollPhysics(),

                  itemBuilder: (context, index) {
                    final chatData = chatController.filteredChatRooms[index];
                    final otherIdUser = chatData.idUser1 == currentUserId
                        ? chatData.idUser2
                        : chatData.idUser1;
                    return ItemUserChatRoom(
                      userName: chatData.otherUserName ?? 'Unknown',
                      imageURL: chatData.otherUserAvatar ?? '',
                      lastMessage: chatData.lastMessage,
                      lastTime: _formatTimestamp(chatData.lastTime),
                      onPressed: () => Get.to(
                        Message(
                          idOtherUser: otherIdUser,
                          idChatRoom: chatData.getIdChatRoom!,
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
