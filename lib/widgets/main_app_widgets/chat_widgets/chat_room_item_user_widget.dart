import 'package:flutter/material.dart';

class ItemUserChatRoom extends StatelessWidget {
  final String userName;
  final String imageURL;
  final String lastMessage;
  final String lastTime;
  final VoidCallback onPressed;
  const ItemUserChatRoom({
    super.key,
    required this.userName,
    required this.imageURL,
    required this.lastMessage,
    required this.lastTime,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageURL.isNotEmpty && imageURL != '';

    return InkWell(
      onTap: onPressed,
      splashColor: Colors.grey.shade200,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
          ),
          color: Colors.white,
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300, width: 1),
                image: DecorationImage(
                  image: hasImage
                      ? NetworkImage(imageURL)
                      : const AssetImage('assets/images/avatar-user.png')
                            as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Name and Last message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Roboto-Bold',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Roboto-Regular',
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // Time
            Text(
              lastTime,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
                fontFamily: 'Roboto-Regular',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
