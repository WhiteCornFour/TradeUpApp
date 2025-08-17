import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/screens/main_app/home/controller/home_controller.dart';
import 'package:tradeupapp/widgets/general/general_button_widget.dart';

class ShopProductDetailBottomNavigation extends StatelessWidget {
  const ShopProductDetailBottomNavigation({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
      ),
      child: Row(
        children: [
          // Chat Button
          GestureDetector(
            onTap: () {
              if (product.userId != null) {
                homeController.handleSendMessage(product.userId!);
              } else {
                print('Home: Cannot enter chatroom');
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: SizedBox(
                width: 52,
                height: 52,
                child: Center(
                  child: Icon(Iconsax.message, color: Colors.black),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          //Check out Button
          Expanded(
            child: SizedBox(
              height: 52,
              child: ButtonGeneral(
                width: double.infinity,
                text: 'Check Out',
                icon: Iconsax.check,
                iconDistance: 18,
                backgroundColor: AppColors.header,
                onPressed: Get.back,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
