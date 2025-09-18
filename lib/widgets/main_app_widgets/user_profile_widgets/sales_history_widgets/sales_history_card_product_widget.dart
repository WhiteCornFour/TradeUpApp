import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_post_card/shop_post_card_description_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_post_card/shop_post_card_header_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_post_card/shop_post_card_image_slider_widget.dart';

class CardProductSalesProduct extends StatefulWidget {
  const CardProductSalesProduct({
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
    required this.buyerName,
    required this.buyerAvatar,
    required this.totalPrice,
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
  final String buyerName;
  final String buyerAvatar; // thêm avatar buyer
  final String totalPrice;

  @override
  State<CardProductSalesProduct> createState() =>
      _CardProductSalesProductState();
}

class _CardProductSalesProductState extends State<CardProductSalesProduct> {
  @override
  Widget build(BuildContext context) {

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
              color: const Color.fromARGB(255, 242, 236, 255),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostCardHeaderShop(
                  userName: widget.userName,
                  timeAgo: widget.timeAgo,
                  userAvatar: widget.userAvatar,
                  userId: widget.userId ?? '',
                  productId: widget.productId ?? '',
                  isOwnPost: widget.userId == widget.currentUserId,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  child: PostCardDescriptionShop(text: widget.description),
                ),
                PostCardImageSliderShop(imageUrls: widget.imageUrls),

                const Divider(),

                // Buyer info với avatar
                ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: widget.buyerAvatar != ""
                        ? NetworkImage(widget.buyerAvatar)
                        : const AssetImage("assets/images/avatar-user.png")
                              as ImageProvider,
                  ),
                  title: Text(
                    widget.buyerName,
                    style: TextStyle(
                      fontFamily: "Roboto-Regular",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.header,
                    ),
                  ),
                  subtitle: const Text(
                    "Buyer",
                    style: TextStyle(
                      fontFamily: "Roboto-Regular",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.header,
                    ),
                  ),
                ),

                // Payment info
                ListTile(
                  leading: const Icon(Icons.attach_money, color: Colors.green),
                  title: Text(
                    "Total payment: ${widget.totalPrice}",
                    style: TextStyle(
                      fontFamily: "Roboto-Regular",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.header,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
