import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_product_detail/shop_product_detail.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_image_container_widget.dart';
import 'package:tradeupapp/widgets/general/general_book_marked_toggle_icon_widget.dart';

class ProductCardVerticalHome extends StatelessWidget {
  const ProductCardVerticalHome({
    super.key,
    required this.product,
    required this.userIdToUserName,
  });

  final ProductModel product;
  final Map<String, String> userIdToUserName;

  @override
  Widget build(BuildContext context) {
    // print(product.userId);
    final userName = userIdToUserName[product.userId] ?? 'Unknown User';
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailShop());
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 4),
              spreadRadius: 1,
            ),
          ],
          color: const Color.fromARGB(255, 242, 236, 255),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Thumbnail, WislistButton, DiscountTag
            Container(
              height: 180,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.transparent,
                // color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white),
              ),
              child: Stack(
                children: [
                  //Thumbnail Image
                  ImageContainerHome(
                    height: 180,
                    width: double.infinity,
                    //Kiểm tra xem có null hoặc empty k
                    imageUrl: product.imageList?.isNotEmpty == true
                        ? product.imageList!.first
                        : '',
                    isNetworkImage: true,
                    applyImageRadius: true,
                  ),

                  //Sale Tag
                  // Positioned(
                  //   top: 12,
                  //   left: 12,
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 8,
                  //       vertical: 4,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black.withOpacity(0.8),
                  //           blurRadius: 50,
                  //           offset: const Offset(0, 2),
                  //           spreadRadius: 7,
                  //         ),
                  //       ],
                  //       color: const Color(0xFFFFE248),
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: Text(
                  //       '25%',
                  //       style: Theme.of(
                  //         context,
                  //       ).textTheme.labelLarge!.apply(color: Colors.black),
                  //     ),
                  //   ),
                  // ),

                  //Favourie Button
                  Positioned(
                    top: 5,
                    right: 8,
                    child: BookmarkedToggleButtonGeneral(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            //Details
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                //Product Name
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName ?? 'Unnamed Product',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto-Regular',
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),

                  const SizedBox(height: 4),

                  //User and Vertification
                  Row(
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Roboto-Light',
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Iconsax.verify5,
                        color: AppColors.background,
                        size: 14,
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Price
                      Text(
                        '\$${product.productPrice?.toStringAsFixed(2) ?? "0.00"}',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Roboto-Bold',
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      ),

                      GestureDetector(
                        onTap: () => {print('Go to chat box')},
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.header,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: SizedBox(
                            width: 44 * 1.2,
                            height: 44 * 1.2,
                            child: Center(
                              child: const Icon(
                                Iconsax.message,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
