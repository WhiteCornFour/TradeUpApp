import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class CartItemShareGeneral extends StatelessWidget {
  final Function onPressedShareProduct;
  final String imageUrl;
  final String fullName;
  final String lastMessage;
  final Function onPressedGoToMessage;

  const CartItemShareGeneral({
    super.key,
    required this.onPressedGoToMessage,
    required this.onPressedShareProduct,
    required this.imageUrl,
    required this.fullName,
    required this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: MaterialButton(
          onPressed: () {
            onPressedGoToMessage();
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageUrl.isNotEmpty
                    ? NetworkImage(imageUrl)
                    : const AssetImage('assets/images/avatar-user.png')
                          as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullName,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 2),
            Text(
              lastMessage,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Roboto-Regular',
                fontSize: 14,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            onPressedShareProduct();
          },
          icon: Icon(Icons.send, color: AppColors.header),
        ),
      ),
    );
  }
}
