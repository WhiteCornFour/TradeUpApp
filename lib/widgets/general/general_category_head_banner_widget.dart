import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryHeadBannerGeneral extends StatelessWidget
    implements PreferredSizeWidget {
  const CategoryHeadBannerGeneral({
    super.key,
    required this.title,
    required this.imagePath,
    required this.overlayColor,
    this.subTitle,
    this.height = 220,
  });

  final String title;
  final String? subTitle;
  final String imagePath;
  final Color overlayColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),

          // Soft gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
              gradient: LinearGradient(
                colors: [
                  overlayColor.withOpacity(0.6),
                  Colors.black.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Title & optional subtitle
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Roboto-Black',
                    fontSize: 24,
                    letterSpacing: 1.1,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.black26,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                if (subTitle != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    subTitle!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Roboto-Regular',
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ],
            ),
          ),

          //Custom round back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: Get.back,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
