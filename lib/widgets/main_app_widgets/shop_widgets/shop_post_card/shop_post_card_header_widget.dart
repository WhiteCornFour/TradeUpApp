import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_post_card/shop_post_card_bottom_sheet_widget.dart';

class PostCardHeaderShop extends StatelessWidget {
  const PostCardHeaderShop({
    super.key,
    required this.userName,
    required this.timeAgo,
    this.userAvatar,
  });

  final String userName, timeAgo;
  final String? userAvatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Avatar + Name & Time
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 22,
                  backgroundImage: userAvatar != null
                      ? NetworkImage(userAvatar!)
                      : null,
                  backgroundColor: Colors.grey[300],
                  child: userAvatar == null
                      ? const Icon(Icons.person, color: Colors.black)
                      : null,
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

          // More Button
          IconButton(
            icon: const Icon(Iconsax.more),
            color: Colors.black,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                backgroundColor: Colors.white,
                builder: (context) => const PostCardBottomSheetShop(),
              );
            },
          ),
        ],
      ),
    );
  }
}
