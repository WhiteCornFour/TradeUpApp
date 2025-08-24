import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MakeAnOfferPriceCalculatorShop extends StatelessWidget {
  final double originPrice;
  final double? offerAmount;

  const MakeAnOfferPriceCalculatorShop({
    super.key,
    required this.originPrice,
    required this.offerAmount,
  });

  @override
  Widget build(BuildContext context) {
    if (offerAmount == null) {
      return const SizedBox.shrink();
    }
    final double diff = offerAmount! - originPrice;
    final bool isRaise = diff > 0;
    final bool isCounter = diff < 0;

    Color color;
    String label;
    IconData iconsax;

    if (isRaise) {
      color = Colors.green;
      label = "Raise";
      iconsax = Iconsax.trend_up;
    } else if (isCounter) {
      color = Colors.red;
      label = "Counter";
      iconsax = Iconsax.trend_down;
    } else {
      color = Colors.grey;
      label = "Same";
      iconsax = Iconsax.minus_cirlce;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Trạng thái Raise/Counter/Same + số chênh
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: color),
              ),
              child: Row(
                children: [
                  Icon(iconsax, size: 14, color: color),
                  const SizedBox(width: 4),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto-Bold',
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Text(
              "${diff > 0 ? '+' : ''}\$${diff.toStringAsFixed(1)}",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto-Regular',
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),

        //Final Price = giá user nhập
        Row(
          children: [
            const Text(
              "Final Price:",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto-Bold',
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              "\$${offerAmount!.toStringAsFixed(1)}",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto-Bold',
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
