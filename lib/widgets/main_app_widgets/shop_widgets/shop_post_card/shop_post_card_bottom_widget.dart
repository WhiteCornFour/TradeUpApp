import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PostCardBottomShop extends StatelessWidget {
  const PostCardBottomShop({super.key, required this.likeCount});

  final int likeCount;

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
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
