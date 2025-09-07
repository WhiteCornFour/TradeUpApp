import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_add_product/controller/shop_add_product_controller.dart';

class AddProductInfoCardShop extends StatelessWidget {
  final double height;

  const AddProductInfoCardShop({super.key, this.height = 110});

  @override
  Widget build(BuildContext context) {
    final addProductController = AddProductController.instance;

    return Obx(() {
      final hasImage = addProductController.imageList.isNotEmpty;
      final coverImage = hasImage ? addProductController.imageList[0] : null;
      final name = addProductController.productNameController.text.isNotEmpty
          ? addProductController.productNameController.text
          : "Unnamed product";
      final price = addProductController.productPriceController.text.isNotEmpty
          ? "\$${addProductController.productPriceController.text}"
          : "\$0.00";
      final tags = addProductController.categories;

      return Container(
        height: height,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            //Ảnh sản phẩm
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: coverImage != null
                  ? Image.file(
                      coverImage,
                      width: height - 20,
                      height: height - 20,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: height - 20,
                      height: height - 20,
                      color: Colors.grey[200],
                      child: const Icon(Iconsax.image, color: Colors.grey),
                    ),
            ),
            const SizedBox(width: 12),

            //Thông tin sản phẩm
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Tên sản phẩm
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto-Regular',
                      color: Colors.black,
                      height: 1.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, 
                    softWrap: false, 
                  ),

                  //Tag list
                  if (tags.isNotEmpty)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: tags
                            .map(
                              (tag) => Container(
                                margin: const EdgeInsets.only(right: 6, top: 4),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.background.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.background,
                                    width: 0.6,
                                  ),
                                ),
                                child: Text(
                                  tag,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'Roboto-Regular',
                                    color: AppColors.background,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),

                  // Giá sản phẩm
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto-Bold',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
