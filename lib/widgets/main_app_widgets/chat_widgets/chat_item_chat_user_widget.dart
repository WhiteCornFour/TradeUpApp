import 'package:flutter/material.dart';

class ItemChatUserChat extends StatelessWidget {
  const ItemChatUserChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15, left: 15, bottom: 10),
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            Container(
              height: 70,
              width: 70,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("lib/assets/images/logo.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Name and Last message
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ngo Hoang Nam',
                    style: TextStyle(
                      fontFamily: 'Roboto-Black',
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Last message',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontFamily: 'Roboto-Regular',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Time
            Text(
              '10:10',
              style: TextStyle(
                color: Colors.grey[600],
                fontFamily: 'Roboto-Regular',
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
