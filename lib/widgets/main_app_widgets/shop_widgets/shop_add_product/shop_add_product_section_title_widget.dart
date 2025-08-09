import 'package:flutter/material.dart';

class AddProductSectionTitleShop extends StatelessWidget {
  final String title;
  final String subtitle;

  const AddProductSectionTitleShop({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontFamily: 'Roboto-Regular', fontSize: 19),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Roboto-Regular',
            fontSize: 14,
            color: Colors.grey,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
