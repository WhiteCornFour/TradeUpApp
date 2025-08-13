import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_add_product/shop_add_product.dart';

class ButtonAddNewFeedPersonal extends StatelessWidget {
  const ButtonAddNewFeedPersonal({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 16, bottom: 20),
          child: FloatingActionButton(
            onPressed: () {
              Get.to(() => AddProductShop());
            },
            backgroundColor: AppColors.background,
            child: Icon(Icons.add, color: AppColors.text, size: 20),
          ),
        ),
      ),
    );
  }
}
