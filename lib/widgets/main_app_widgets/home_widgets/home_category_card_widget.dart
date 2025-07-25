import 'package:flutter/material.dart';
import 'package:tradeupapp/models/category_model.dart';

class CategoryCardHome extends StatelessWidget {
  const CategoryCardHome({
    super.key,
    required this.category,
    required this.width,
    required this.height,
    this.onTap,
  });

  final CategoryModel category;
  final double width;
  final double height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(category.icon, size: 24),
              const SizedBox(height: 4),
              Text(
                '${category.count} items',
                style: const TextStyle(fontSize: 11),
              ),
              Text(
                category.name,
                style: const TextStyle(
                  fontFamily: 'Roboto-Black',
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
