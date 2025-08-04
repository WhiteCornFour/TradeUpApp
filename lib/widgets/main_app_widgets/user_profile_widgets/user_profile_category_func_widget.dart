import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class CategoryFuncProfile extends StatelessWidget {
  const CategoryFuncProfile({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 7, top: 5),
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.header,
                fontFamily: 'Roboto-Medium',
                fontSize: 14,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}