import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/chat/controllers/message_controller.dart';
import 'package:tradeupapp/widgets/general/general_custom_dialog.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/message_app_bar_custom_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/message_bottom_text_field_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/message_emty_message_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/message_item_message_widget.dart';

class Message extends StatefulWidget {
  final String idOtherUser;
  final String idChatRoom;

  const Message({
    super.key,
    required this.idOtherUser,
    required this.idChatRoom,
  });

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  late final MessageController messageController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    messageController = Get.put(
      MessageController(
        idOtherUser: widget.idOtherUser,
        idChatRoom: widget.idChatRoom,
      ),
    );
    _scrollController = ScrollController();
  }

  String _formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    String hourMinute = DateFormat('HH:mm').format(dateTime);
    String day = dateTime.day.toString();
    String month = 'Th${dateTime.month}';
    return '$hourMinute $day $month';
  }

  void _showDialogBeforeDelete() {
    CustomDialogGeneral.show(
      context,
      'Delete Conversation?',
      'Are you sure you want to delete this conversation? This action cannot be undone.',
      () {
        messageController.handleDeleteChatRoom();
      },
      numberOfButton: 2,
      textButton1: 'Delete',
      image: 'warning.jpg',
    );
  }

  void _showDialogBeforeBlock() {
    CustomDialogGeneral.show(
      context,
      'Block This User?',
      'Are you sure you want to block this user? They will no longer be able to message you or see your profile.',
      () {
        messageController.handleBlockChatRoom();
      },
      numberOfButton: 2,
      textButton1: 'Block',
      image: 'warning.jpg',
    );
  }

  void _showDialogBeforeDeleteMessage(String idMessage) {
    CustomDialogGeneral.show(
      context,
      'Delete message?',
      'Are you sure you want to delete this message? This action cannot be undone.',
      () {
        messageController.handleDeleteMessage(idMessage);
      },
      numberOfButton: 2,
      textButton1: 'Delete',
    );
  }

  Widget _buildMessage(
    String idMessage,
    MainAxisAlignment mainAxisAlignment,
    CrossAxisAlignment crossAxisAlignment,
    double topLeft,
    double topRight,
    String time, {
    String? content,
    String? imageURL,
  }) {
    return ItemMessageMessage(
      onLongPressed: () {
        _showDialogBeforeDeleteMessage(idMessage);
      },
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      timestamp: time,
      content: content,
      imageURL: imageURL,
      isImage: imageURL != null,
      topLeft: topLeft,
      topRight: topRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          final user = messageController.user.value;
          if (user == null || user.fullName == null) {
            return AppBarCustomMessage(
              userName: 'Loading...',
              onPressedBlock: () {},
              onPressedDelete: () {},
            );
          }
          return AppBarCustomMessage(
            userName: user.fullName!,
            avatarUrl: user.avtURL,
            onPressedBlock: _showDialogBeforeBlock,
            onPressedDelete: _showDialogBeforeDelete,
          );
        }),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Expanded(
              child: Obx(() {
                if (messageController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColors.background,
                      color: AppColors.text,
                    ),
                  );
                }

                if (messageController.messageList.isEmpty) {
                  final user = messageController.user.value;
                  if (user != null) {
                    return EmtyMessage(
                      fullname: user.fullName!,
                      imageURL: user.avtURL ?? '',
                    );
                  }
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                });

                return ListView.builder(
                  itemCount: messageController.messageList.length,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    final message = messageController.messageList[index];
                    final isCurrentUser =
                        widget.idOtherUser != message.idSender;

                    final mainAxisAlignment = isCurrentUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start;
                    final crossAxisAlignment = isCurrentUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start;
                    final topLeft = isCurrentUser ? 12.0 : 0.0;
                    final topRight = isCurrentUser ? 0.0 : 12.0;

                    bool hasImage = message.imageUrl.isNotEmpty;
                    bool hasText =
                        message.content.isNotEmpty &&
                        message.content != 'Sent a photo';

                    String time = _formatTimestamp(message.timestamp);

                    if (hasImage && hasText) {
                      return Column(
                        children: [
                          _buildMessage(
                            message.idMessage!,
                            mainAxisAlignment,
                            crossAxisAlignment,
                            topLeft,
                            topRight,
                            time,
                            imageURL: message.imageUrl,
                          ),
                          _buildMessage(
                            message.idMessage!,
                            mainAxisAlignment,
                            crossAxisAlignment,
                            topLeft,
                            topRight,
                            time,
                            content: message.content,
                          ),
                        ],
                      );
                    }

                    if (hasImage) {
                      return _buildMessage(
                        message.idMessage!,
                        mainAxisAlignment,
                        crossAxisAlignment,
                        topLeft,
                        topRight,
                        time,
                        imageURL: message.imageUrl,
                      );
                    }

                    return _buildMessage(
                      message.idMessage!,
                      mainAxisAlignment,
                      crossAxisAlignment,
                      topLeft,
                      topRight,
                      time,
                      content: message.content,
                    );
                  },
                );
              }),
            ),
            SafeArea(
              child: Obx(
                () => BottomTextFieldMessage(
                  messageController: messageController.messageController,
                  isLoadingButton: messageController.isLoadingButton.value,
                  onPressedSendMessage: messageController.handleSendMessage,
                  onPressedUploadImage: () {
                    messageController.showBottomSheet(context);
                  },
                  imageFile: messageController.imageFile.value,
                  onPressedDeleteImageFile:
                      messageController.deleletImageFileSelected,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
