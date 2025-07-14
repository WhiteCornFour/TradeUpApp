import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';

class ProductDetailHeaderShop extends StatelessWidget {
  const ProductDetailHeaderShop({
    super.key,
    required this.rating,
    required this.ratingCount,
    required this.userAvatar,
    required this.userName,
    this.isVerification = false,
  });

  final String rating, ratingCount, userAvatar, userName;
  final bool isVerification;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar
        CircleAvatar(radius: 20, backgroundImage: NetworkImage(userAvatar)),
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
              // Rating And Count
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
          onPressed: () {},
          icon: const Icon(Icons.share),
          color: Colors.black,
        ),
      ],
    );
  }
}
