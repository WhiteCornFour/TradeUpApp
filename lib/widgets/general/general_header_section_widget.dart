import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class HeaderSectionGeneral extends StatelessWidget {
  const HeaderSectionGeneral({
    super.key,
    required this.title,
    this.onTap,
    this.icon = Iconsax.category,
    this.fontSize = 20,
    this.showViewAll = true,
    this.paddingHorizontal = 30,
    this.paddingVertical = 5,
  });

  final String title;
  final VoidCallback? onTap;
  final IconData icon;
  final double fontSize;
  final bool showViewAll;
  final double paddingHorizontal, paddingVertical;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 15),
          Text(
            title,
            style: TextStyle(fontSize: fontSize, fontFamily: 'Roboto-Bold'),
          ),
          const Spacer(),

          //If false, it will enable 'View all' section
          if (showViewAll)
            GestureDetector(
              onTap: onTap,
              child: Row(
                children: const [
                  Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.background,
                      fontFamily: 'Roboto-Light',
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color.fromARGB(255, 144, 182, 216),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
