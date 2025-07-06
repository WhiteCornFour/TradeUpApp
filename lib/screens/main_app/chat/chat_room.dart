import 'package:flutter/material.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/chat_bottom_text_field_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/chat_item_message_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/chat_app_bar_custom_widget.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarCustomChat(),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 15),
              ItemMessageChat(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                topLeft: 0,
              ),
              ItemMessageChat(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                topRight: 0,
              ),
            ],
          ),
        ),
        bottomSheet: BottomTextFieldChat(),
      ),
    );
  }
}
