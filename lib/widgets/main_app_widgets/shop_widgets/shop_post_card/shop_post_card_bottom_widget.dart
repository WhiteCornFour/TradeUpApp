import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/screens/main_app/shop/controllers/shop_controller.dart';

class PostCardBottomShop extends StatelessWidget {
  const PostCardBottomShop({
    super.key,
    required this.likeCount,
    required this.userId,
    required this.userName,
  });

  final int likeCount;
  final String? userId, userName;

  @override
  Widget build(BuildContext context) {
    final shopController = Get.find<ShopController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Like + Comment
          Row(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.heart),
                    color: Colors.black,
                    tooltip: 'Like',
                  ),
                  SizedBox(width: 4),
                  Text('$likeCount Likes', style: TextStyle(fontSize: 14)),
                ],
              ),
              SizedBox(width: 16),
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(Iconsax.messages_3),
              //   color: Colors.black,
              //   tooltip: 'Comment',
              // ),
            ],
          ),

          //Share + Wishlist
          Row(
            children: [
              IconButton(
                onPressed: () {
                  shopController.handleCheckOrStartChat(
                    userId!,
                    context,
                    userName ?? 'User not Availabel',
                  );
                },
                icon: Icon(Iconsax.messages_3),
                color: Colors.black,
                tooltip: 'Contact',
              ),
              IconButton(
                onPressed: () {
                },
                icon: Icon(Icons.share),
                color: Colors.black,
                tooltip: 'Share',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
