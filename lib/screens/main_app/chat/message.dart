import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/screens/main_app/chat/controllers/message_controller.dart';
import 'package:tradeupapp/widgets/general/general_custom_dialog.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/message_app_bar_custom_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/message_bottom_text_field_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/message_emty_message_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/message_item_message_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/message_item_product_message_widget.dart';

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

    // Auto scroll khi có tin nhắn mới
    ever(messageController.messageList, (_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent, // vì reverse: true
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
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

  void _showDialogBeforeDeleteMessage(String idMessage, String senderID) {
    CustomDialogGeneral.show(
      context,
      'Delete message?',
      'Are you sure you want to delete this message? This action cannot be undone.',
      () {
        messageController.handleDeleteMessage(idMessage, senderID);
      },
      numberOfButton: 2,
      textButton1: 'Delete',
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

                return ListView.builder(
                  reverse: true, // Tin nhắn mới ở cuối
                  controller: _scrollController,
                  itemCount: messageController.messageList.length,
                  itemBuilder: (context, index) {
                    final reversedIndex =
                        messageController.messageList.length - 1 - index;
                    final message =
                        messageController.messageList[reversedIndex];
                    final isCurrentUser =
                        widget.idOtherUser != message.idSender;

                    bool isRight = isCurrentUser;
                    bool hasImage = message.imageUrl.isNotEmpty;
                    bool hasText =
                        message.content.isNotEmpty &&
                        message.content != 'Sent a photo';

                    String timestamp = _formatTimestamp(message.timestamp);

                    // Nếu là sản phẩm
                    if (message.status == 2) {
                      var db = DatabaseService();
                      return FutureBuilder<ProductModel?>(
                        future: db.getProductById(message.content),
                        builder: (context, snapshot) {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (_) => _scrollToBottom(),
                          );
                          if (!snapshot.hasData) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 120,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blue,
                                ),
                              ),
                            );
                          }

                          return ItemProductMessage(
                            isRight: isRight,
                            onPressed: (idProduct) {},
                            timestamp: timestamp,
                            product: snapshot.data!,
                          );
                        },
                      );
                    }

                    // Có cả ảnh và text
                    if (hasImage && hasText) {
                      return Column(
                        children: [
                          ItemMessageMessage(
                            timestamp: timestamp,
                            onLongPressed: () {
                              _showDialogBeforeDeleteMessage(
                                message.idMessage!,
                                messageController.idCurrentUser,
                              );
                            },
                            isRight: isRight,
                            content: message.content,
                          ),
                          ItemMessageMessage(
                            timestamp: timestamp,
                            onLongPressed: () {
                              _showDialogBeforeDeleteMessage(
                                message.idMessage!,
                                messageController.idCurrentUser,
                              );
                            },
                            isRight: isRight,
                            isImage: true,
                            imageURL: message.imageUrl,
                          ),
                        ],
                      );
                    }

                    // Chỉ có ảnh
                    if (hasImage) {
                      return ItemMessageMessage(
                        timestamp: timestamp,
                        onLongPressed: () {
                          _showDialogBeforeDeleteMessage(
                            message.idMessage!,
                            messageController.idCurrentUser,
                          );
                        },
                        isRight: isRight,
                        isImage: true,
                        imageURL: message.imageUrl,
                      );
                    }

                    // Chỉ có text
                    return ItemMessageMessage(
                      timestamp: timestamp,
                      onLongPressed: () {
                        _showDialogBeforeDeleteMessage(
                          message.idMessage!,
                          messageController.idCurrentUser,
                        );
                      },
                      isRight: isRight,
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
