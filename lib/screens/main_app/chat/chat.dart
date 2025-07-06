import 'package:flutter/material.dart';
import 'package:tradeupapp/widgets/main_app_widgets/chat_widgets/chat_item_chat_user_widget.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _Chat();
}

class _Chat extends State<Chat> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "messages",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto-Medium',
              fontSize: 27,
            ),
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade500, width: 0.5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto-Regular',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                ],
              ),
            ),
            SizedBox(height: 20),

            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 20),
                children: const [
                  ItemChatUserChat(),
                  ItemChatUserChat(),
                  ItemChatUserChat(),
                  ItemChatUserChat(),
                  ItemChatUserChat(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
