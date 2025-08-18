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
    required this.productId,
    required this.likedBy,
  });

  final int likeCount;
  final String? userId, userName, productId;
  final List<String> likedBy;

  @override
  Widget build(BuildContext context) {
    final shopController = Get.find<ShopController>();
    String? currentUserId = shopController.currentUserId.value;
    //Kiểm tra xem người dùng hiện tại có nằm trong danh sách người like bài viết
    final bool isLiked = likedBy.contains(currentUserId);

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
                    onPressed: () async {
                      print('User id liked post card: $currentUserId');
                      print('Product id liked post card: $productId');
                      if (userId == null || productId == null) return;

                      if (isLiked) {
                        await shopController.unlikeProduct(
                          productId!,
                          currentUserId,
                        );
                      } else {
                        await shopController.likeProduct(
                          productId!,
                          currentUserId,
                        );
                      }
                    },
                    icon: Icon(
                      isLiked ? Iconsax.heart5 : Iconsax.heart,
                      color: isLiked ? Colors.red : Colors.black,
                    ),
                    tooltip: isLiked ? 'Unlike' : 'Like',
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
                onPressed: () {},
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
