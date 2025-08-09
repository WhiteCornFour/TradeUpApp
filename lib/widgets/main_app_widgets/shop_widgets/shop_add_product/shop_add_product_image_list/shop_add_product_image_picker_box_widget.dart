import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:iconsax/iconsax.dart';

class AddProductImagePickerBoxShop extends StatelessWidget {
  const AddProductImagePickerBoxShop({
    super.key,
    this.size = 120,
    this.borderRadius = 12,
    this.iconSize = 40,
    this.iconColor = Colors.grey,
    this.image,
    this.onTap,
  });

  final double size;
  final double borderRadius;
  final double iconSize;
  final Color iconColor;
  final ImageProvider? image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          color: Colors.grey,
          dashPattern: const [6, 4],
          strokeWidth: 1.5,
          radius: Radius.circular(borderRadius),
          padding: EdgeInsets.zero,
        ),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: image != null
                ? DecorationImage(image: image!, fit: BoxFit.cover)
                : null,
          ),
          child: image == null
              ? Center(
                  child: Icon(Iconsax.image, size: iconSize, color: iconColor),
                )
              : null,
        ),
      ),
    );
  }
}
