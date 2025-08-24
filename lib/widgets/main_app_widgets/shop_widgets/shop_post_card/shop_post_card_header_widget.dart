import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_post_card/shop_post_card_bottom_sheet_widget.dart';

class PostCardHeaderShop extends StatelessWidget {
  const PostCardHeaderShop({
    super.key,
    required this.userId,
    required this.productId,
    required this.userName,
    required this.timeAgo,
    this.userAvatar,
    this.isOwnPost = false,
  });

  final String userId, productId, userName, timeAgo;
  final String? userAvatar;
  final bool isOwnPost;

  @override
  Widget build(BuildContext context) {
    // print('Status: {$isOwnPost}');

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Avatar + Name & Time
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 22,
                  backgroundImage: userAvatar != ''
                      ? NetworkImage(userAvatar!)
                      : const AssetImage('assets/images/avatar-user.png')
                            as ImageProvider,
                  backgroundColor: Colors.grey[300],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      userName,
                      style: const TextStyle(
                        fontFamily: 'Roboto-Bold',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    timeAgo,
                    style: const TextStyle(
                      fontFamily: 'Roboto-Regular',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),

          //More Button chỉ hiển thị nếu không phải bài post của chính user
          if (!isOwnPost)
            IconButton(
              icon: const Icon(Iconsax.more),
              color: Colors.black,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  builder: (context) => PostCardBottomSheetShop(
                    userId: userId,
                    userName: userName,
                    productId: productId,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
