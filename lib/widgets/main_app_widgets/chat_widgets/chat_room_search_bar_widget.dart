import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class SearchBarChatRoom extends StatelessWidget {
  final VoidCallback? onTap;
  final String hintText;
  final TextEditingController searchController;
  const SearchBarChatRoom({
    super.key,
    required this.onTap,
    required this.hintText,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(blurRadius: 5, offset: Offset(0, 2), color: Colors.black12),
        ],
      ),
      child: Row(
        children: [
          Icon(Iconsax.search_normal, size: 24, color: Colors.black54),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: searchController,
              onTap: onTap,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto-Regular',
                color: AppColors.header,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                isDense: true,
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto-ThinItalic',
                  fontWeight: FontWeight.w700,
                  color: AppColors.header,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
