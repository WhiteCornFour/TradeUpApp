import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/shop/personal.dart';

class ProductDetailHeaderShop extends StatelessWidget {
  const ProductDetailHeaderShop({
    super.key,
    required this.sellerId,
    required this.rating,
    required this.ratingCount,
    required this.userAvatar,
    required this.userName,
    this.isVerification = false,
    required this.onPressedShareProduct,
  });

  final String sellerId, rating, ratingCount, userName;
  final bool isVerification;
  final String? userAvatar;
  final Function onPressedShareProduct;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Avatar
        GestureDetector(
          onTap: () {
            print("Go to personal of $sellerId");
            // Điều hướng sang trang Personal
            Get.to(() => Personal(idUser: sellerId));
          },
          child: CircleAvatar(
            radius: 20,
            backgroundImage: userAvatar != null && userAvatar!.isNotEmpty
                ? NetworkImage(userAvatar!)
                : const AssetImage("assets/images/avatar-user.png")
                      as ImageProvider,
          ),
        ),
        const SizedBox(width: 10),

        //User Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //User Name And Verification
              Row(
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  if (isVerification) ...[
                    const SizedBox(width: 4),
                    const Icon(
                      Iconsax.verify5,
                      color: AppColors.background,
                      size: 18,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              //Rating And Count
              Row(
                children: [
                  const Icon(Iconsax.star5, color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    '$rating ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    '($ratingCount)',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Share Button
        IconButton(
          onPressed: () {
            onPressedShareProduct();
          },
          icon: const Icon(Icons.share),
          color: Colors.black,
        ),
      ],
    );
  }
}
