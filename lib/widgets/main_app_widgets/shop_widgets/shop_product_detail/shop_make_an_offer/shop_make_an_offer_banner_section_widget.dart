import 'package:flutter/material.dart';

class MakeAnOfferBannerSectionShop extends StatelessWidget {
  const MakeAnOfferBannerSectionShop({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            image,

            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 20),

        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Roboto-Bold',
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                subTitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
