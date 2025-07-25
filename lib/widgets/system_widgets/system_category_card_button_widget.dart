import 'package:flutter/material.dart';
import 'package:tradeupapp/models/category_model.dart';

class CategoryCardButtonSystem extends StatelessWidget {
  const CategoryCardButtonSystem({
    super.key,
    required this.category,
    this.onTap,
    this.showBorder = false,
  });

  final CategoryModel category;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.circular(16),
          border: showBorder ? Border.all(color: Colors.black12) : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(category.icon, size: 40, color: Colors.black87),
            SizedBox(height: 12),
            Text(
              category.name,
              style: TextStyle(
                fontFamily: 'Roboto-Bold',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${category.count} products',
              style: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
