import 'package:flutter/material.dart';
import 'package:tradeupapp/models/category_model.dart';

class CategoryCardHome extends StatelessWidget {
  final CategoryModel category;
  final double width;
  final double height;

  const CategoryCardHome({
    super.key,
    required this.category,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            SizedBox(height: 4),
            Text('${category.count} items', style: TextStyle(fontSize: 11)),
            Text(
              category.name,
              style: TextStyle(fontFamily: 'Roboto-Black', fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
