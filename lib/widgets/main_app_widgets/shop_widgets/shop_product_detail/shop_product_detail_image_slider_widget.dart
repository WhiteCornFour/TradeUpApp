import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_product_detail/controller/shop_product_detail_controller.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_post_card/shop_post_card_image_container_widget.dart';

class ProductDetailImageSliderShop extends StatelessWidget {
  const ProductDetailImageSliderShop({
    super.key,
    required this.firstImage,
    required this.imageList,
  });

  final String firstImage;
  final List<String> imageList;

  @override
  Widget build(BuildContext context) {
    final productDetailController = Get.find<ProductDetailController>();
    productDetailController.selectedImage.value = firstImage;

    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          //Big Image Container
          SizedBox(
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Obx(
                  () => Image.network(
                    productDetailController.selectedImage.value,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          //Gradient for Status Bar
          Container(
            height: MediaQuery.of(context).padding.top + 16,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black54, Colors.transparent],
              ),
            ),
          ),

          //Small Image Slider
          Positioned(
            right: 0,
            bottom: 30,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                height: 80,
                child: imageList.length <= 3
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageList.map((imageUrl) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Obx(
                              () => PostCardImageContainerShop(
                                isNetworkImage: true,
                                width: 80,
                                backgroundColor: Colors.white,
                                border: Border.all(
                                  color:
                                      productDetailController
                                              .selectedImage
                                              .value ==
                                          imageUrl
                                      ? AppColors.header
                                      : Colors.grey.shade300,
                                  width: 2,
                                ),
                                padding: const EdgeInsets.all(8),
                                imageUrl: imageUrl,
                                onPressed: () =>
                                    productDetailController.setImage(imageUrl),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        // ignore: unnecessary_underscores
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemCount: imageList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final imageUrl = imageList[index];
                          return Obx(
                            () => PostCardImageContainerShop(
                              isNetworkImage: true,
                              width: 80,
                              backgroundColor: Colors.white,
                              border: Border.all(
                                color:
                                    productDetailController
                                            .selectedImage
                                            .value ==
                                        imageUrl
                                    ? AppColors.header
                                    : Colors.grey.shade300,
                                width: 2,
                              ),
                              padding: const EdgeInsets.all(8),
                              imageUrl: imageUrl,
                              onPressed: () =>
                                  productDetailController.setImage(imageUrl),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
