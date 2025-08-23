import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class ItemMessageMessage extends StatelessWidget {
  final bool isImage;
  final String? imageURL;
  final String? content;
  final String timestamp;
  final Function onLongPressed;
  final bool isRight;

  const ItemMessageMessage({
    super.key,
    required this.timestamp,
    required this.onLongPressed,
    this.content,
    this.isImage = false,
    this.imageURL,
    required this.isRight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        onLongPressed();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: isRight
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: isRight
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: isImage ? _buildImage(context) : _buildTextBubble(),
                ),
                const SizedBox(height: 3),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    timestamp,
                    style: TextStyle(
                      color: AppColors.header,
                      fontFamily: 'Roboto-Regular',
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextBubble() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.header,
        boxShadow: [
          BoxShadow(
            color: AppColors.header,
            blurRadius: 2,
            blurStyle: BlurStyle.outer,
          ),
        ],
        borderRadius: BorderRadius.only(
          topRight: isRight ? Radius.circular(0) : Radius.circular(12),
          bottomRight: const Radius.circular(12),
          bottomLeft: const Radius.circular(12),
          topLeft: isRight ? Radius.circular(12) : Radius.circular(0),
        ),
      ),
      child: Text(
        content ?? '',
        style: TextStyle(
          color: AppColors.text,
          fontFamily: 'Roboto-Regular',
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: isRight ? Radius.circular(0) : Radius.circular(12),
        bottomRight: const Radius.circular(12),
        bottomLeft: const Radius.circular(12),
        topLeft: isRight ? Radius.circular(12) : Radius.circular(0),
      ),
      child: Image(
        image: (imageURL != null && imageURL!.isNotEmpty)
            ? NetworkImage(imageURL!)
            : const AssetImage('assets/images/logo.png') as ImageProvider,
        height: MediaQuery.of(context).size.width * 0.7,
        fit: BoxFit.cover,
      ),
    );
  }
}
