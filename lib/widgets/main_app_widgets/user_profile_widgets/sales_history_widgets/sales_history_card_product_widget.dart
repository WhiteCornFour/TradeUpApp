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
  final String buyerAvatar;
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
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color.fromARGB(255, 255, 233, 197),
                width: 1,
              ),
              gradient: LinearGradient(
                colors: [Colors.white, Colors.purple.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.text,
                        const Color.fromARGB(255, 212, 240, 255),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: PostCardHeaderShop(
                    userName: widget.userName,
                    timeAgo: widget.timeAgo,
                    userAvatar: widget.userAvatar,
                    userId: widget.userId ?? '',
                    productId: widget.productId ?? '',
                    isOwnPost: widget.userId == widget.currentUserId,
                  ),
                ),

                /// Description
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: PostCardDescriptionShop(text: widget.description),
                ),

                /// Images
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: PostCardImageSliderShop(imageUrls: widget.imageUrls),
                  ),
                ),

                const SizedBox(height: 12),

                /// Buyer info block
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.text,
                        const Color.fromARGB(255, 212, 240, 255),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),

                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundImage: widget.buyerAvatar != ""
                            ? NetworkImage(widget.buyerAvatar)
                            : const AssetImage("assets/images/avatar-user.png")
                                  as ImageProvider,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.buyerName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.header,
                            ),
                          ),
                          const Text(
                            "Buyer",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),

                /// Payment info badge
                Padding(
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                    bottom: 16,
                    top: 4,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.text,
                          const Color.fromARGB(255, 212, 240, 255),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.attach_money,
                          color: AppColors.header,
                          size: 24,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Total Payment: ${widget.totalPrice}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.header,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Divider(),
        ],
      ),
    );
  }
}
