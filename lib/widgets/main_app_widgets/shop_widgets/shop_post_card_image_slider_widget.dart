import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_image_container_widget.dart';

class PostCardImageSliderShop extends StatefulWidget {
  const PostCardImageSliderShop({super.key, required this.imageUrls});

  final List<String> imageUrls;

  @override
  State<PostCardImageSliderShop> createState() =>
      _PostCardImageSliderShopState();
}

class _PostCardImageSliderShopState extends State<PostCardImageSliderShop> {
  int currentImageIndex = 0; //Image Count Index

  @override
  Widget build(BuildContext context) {
    return Container(
      // Post Card Image Slider (Image CarouselSlider and Number Count)
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias, //Border for image
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Image Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1, //Only view 1 image per slide
                enableInfiniteScroll: false,
                height: 400,

                // index: The position (zero-based) of the currently visible image in the carousel.
                // reason: The trigger that caused the page change (e.g., user swipe, automatic animation, etc.).
                // setState: Rebuilds the widget to reflect updated UI state.
                // In this case, it updates currentImageIndex to match the new image index.
                onPageChanged: (index, reason) {
                  setState(() {
                    currentImageIndex = index;
                  });
                },
              ),
              //
              items: widget.imageUrls.map((imgPath) {
                return ImageContainerShop(
                  imageUrl: imgPath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 400,
                  applyImageRadius: false,
                );
              }).toList(),
            ),

            // Number Image Count
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  // Display current image position as "current/total"
                  // +1 because index starts at 0, but we want to show 1-based counting to users
                  '${currentImageIndex + 1}/${widget.imageUrls.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
