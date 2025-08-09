import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_add_product/controller/shop_add_product_controller.dart';

class AddProductHelpCollapsedShop extends StatelessWidget {
  const AddProductHelpCollapsedShop({super.key});

  @override
  Widget build(BuildContext context) {
    final addProductController = Get.put(AddProductController());

    return GestureDetector(
      onTap: () {
        addProductController.showHelpDialogAgain(); //Mở lại hộp trợ giúp
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.backgroundGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            /// Icon
            const Icon(Iconsax.info_circle, color: Colors.grey, size: 22),
            const SizedBox(width: 10),

            /// Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Need help?",
                    style: TextStyle(
                      fontFamily: 'Roboto-Bold',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Tap here to contact our support",
                    style: TextStyle(
                      fontFamily: 'Roboto-Regular',
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            /// Icon mũi tên
            const Icon(Iconsax.arrow_right_3, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
