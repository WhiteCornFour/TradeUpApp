import 'package:flutter/material.dart';

class ImageContainerHome extends StatelessWidget {
  const ImageContainerHome({
    super.key,
    this.border,
    this.padding,
    this.onPressed,
    this.width,
    this.height,
    this.applyImageRadius = true,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.backgroundColor = Colors.white,
    this.isNetworkImage = false,
    this.borderRadius = 16,
    this.imagePadding = 12,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;
  final double imagePadding;

  bool get hasValidAvatar => imageUrl.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: hasValidAvatar
              ? Padding(
                  padding: EdgeInsets.all(imagePadding),
                  child: isNetworkImage
                      ? Image.network(imageUrl, fit: fit)
                      : Image.asset(imageUrl, fit: fit),
                )
              : const Icon(Icons.person, color: Colors.black),
        ),
      ),
    );
  }
}
