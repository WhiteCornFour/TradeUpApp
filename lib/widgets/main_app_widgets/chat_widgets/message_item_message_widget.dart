import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class ItemMessageMessage extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double topRight;
  final double topLeft;
  final bool isImage;
  final String? imageURL;
  final String? content;
  final String timestamp;
  final Function onLongPressed;

  const ItemMessageMessage({
    super.key,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.timestamp,
    required this.onLongPressed,
    this.content,
    this.topRight = 12,
    this.topLeft = 12,
    this.isImage = false,
    this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        onLongPressed();
        print('OnlongPress');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Column(
              crossAxisAlignment: crossAxisAlignment,
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
          topRight: Radius.circular(topRight),
          bottomRight: const Radius.circular(12),
          bottomLeft: const Radius.circular(12),
          topLeft: Radius.circular(topLeft),
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
        topRight: Radius.circular(topRight),
        bottomRight: const Radius.circular(12),
        bottomLeft: const Radius.circular(12),
        topLeft: Radius.circular(topLeft),
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
