import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetailPriceTagShop extends StatelessWidget {
  final double finalPrice;

  const ProductDetailPriceTagShop({super.key, required this.finalPrice});

  String formatCurrency(double value) {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '',
      decimalDigits: 2,
    );
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ký hiệu $
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            '\$',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(width: 2),

        // giá chính
        Text(
          formatCurrency(finalPrice),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}
