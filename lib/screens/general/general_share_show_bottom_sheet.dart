import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/chat_room_model.dart';
import 'package:tradeupapp/screens/main_app/chat/controllers/message_controller.dart';
import 'package:tradeupapp/screens/main_app/chat/message.dart';
import 'package:tradeupapp/widgets/general/general_cart_item_share_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/chat_room_no_chat_found_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/chat_room_search_bar_widget.dart';

class ShareShowBottomSheetGeneral {
  static void show(
    BuildContext context,
    List<ChatRoomModel> chatRooms,
    TextEditingController searchController,
    bool isLoading,
    Function(String) onPressedSendProduct,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundGrey,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  'Send to a Friend',
                  style: TextStyle(
                    color: AppColors.header,
                    fontFamily: 'Roboto-Medium',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 10),

                // Search bar
                SearchBarChatRoom(
                  onTap: () {},
                  hintText: 'Looking for someone?',
                  searchController: searchController,
                ),

                const SizedBox(height: 10),

                // List Chat Rooms
                Obx(() {
                  if (isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColors.background,
                        color: AppColors.text,
                      ),
                    );
                  }

                  if (chatRooms.isEmpty) {
                    return NoChatFoundChatRoom();
                  }

                  if (chatRooms.isEmpty) {
                    return NoChatFoundChatRoom();
                  }
                  return SizedBox(
                    height: 350,
                    child: ListView.builder(
                      itemCount: chatRooms.length,
                      itemBuilder: (context, index) {
                        final chatRoom = chatRooms[index];
                        final idOtherUser =
                            chatRoom.idUser1 !=
                                MessageController().idCurrentUser
                            ? chatRoom.idUser1
                            : chatRoom.idUser2;

                        return CartItemShareGeneral(
                          onPressedGoToMessage: () {
                            Get.to(
                              Message(
                                idOtherUser: idOtherUser,
                                idChatRoom: chatRoom.idChatRoom!,
                              ),
                            );
                          },
                          onPressedShareProduct: () {
                            onPressedSendProduct(chatRoom.idChatRoom!);
                          },
                          fullName: chatRoom.otherUserName ?? 'Unknown',
                          imageUrl: chatRoom.otherUserAvatar ?? '',
                          lastMessage: chatRoom.lastMessage,
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
