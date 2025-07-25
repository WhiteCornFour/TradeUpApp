import 'package:flutter/material.dart';

class ProductDetailPriceTagShop extends StatelessWidget {
  final String originalPrice;
  final String finalPrice;
  final String discountTag;
  final bool isOnSale;

  const ProductDetailPriceTagShop({
    super.key,
    required this.originalPrice,
    required this.finalPrice,
    this.discountTag = '',
    this.isOnSale = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isOnSale)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE248),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              discountTag,
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(color: Colors.black),
            ),
          ),

        //if isOnSale is true
        if (isOnSale) SizedBox(width: 12),

        //Original Price
        if (isOnSale)
          Text(
            originalPrice,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),

        if (isOnSale) const SizedBox(width: 12),

        //Final Price
        Text(
          finalPrice,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
