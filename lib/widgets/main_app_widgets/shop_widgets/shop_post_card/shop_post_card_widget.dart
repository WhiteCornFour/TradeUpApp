import 'package:flutter/material.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_post_card/shop_post_card_bottom_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_post_card/shop_post_card_description_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_post_card/shop_post_card_header_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_post_card/shop_post_card_image_slider_widget.dart';

class PostCardShop extends StatefulWidget {
  const PostCardShop({
    super.key,
    required this.imageUrls,
    required this.description,
    required this.userName,
    required this.timeAgo,
    required this.likedBy,
    required this.userAvatar,
    this.productId,
    this.userId,
    this.currentUserId,
    this.onPressed,
  });

  final List<String> imageUrls;
  final String description;
  final String userName, userAvatar;
  final String timeAgo;
  final List<String> likedBy;
  final VoidCallback? onPressed;
  final String? userId;
  final String? currentUserId;
  final String? productId;

  @override
  State<PostCardShop> createState() => _PostCardShop();
}

class _PostCardShop extends State<PostCardShop> {
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // print('PostCardShopPersonal UserId: ${widget.userId}');
    // print('PostCardShopPersonal CurrentUserId: ${widget.currentUserId}');
    int likeCount = widget.likedBy.length;

    return GestureDetector(
      onTap: widget.onPressed,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: Offset(0, 4),
                  spreadRadius: 1,
                ),
              ],
              color: Color.fromARGB(255, 242, 236, 255),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Post Card Header: Avatar + Name + Option
                PostCardHeaderShop(
                  userName: widget.userName,
                  timeAgo: widget.timeAgo,
                  userAvatar: widget.userAvatar,
                  userId: widget.userId ?? '',
                  productId: widget.productId ?? '',
                  isOwnPost: widget.userId == widget.currentUserId,
                ),

                //Post Card Description
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: PostCardDescriptionShop(text: widget.description),
                ),

                //Post Card Image Slider(Image CarouselSlider and Number Count)
                PostCardImageSliderShop(imageUrls: widget.imageUrls),

                //Post Card Bottom: Like, Chat, Bookmark
                PostCardBottomShop(
                  likeCount: likeCount,
                  userId: widget.userId,
                  userName: widget.userName,
                  productId: widget.productId!,
                  likedBy: widget.likedBy,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
