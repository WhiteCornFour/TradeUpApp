import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_add_product/controller/shop_add_product_controller.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_help_box/shop_add_product_help_collapsed_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_add_product/shop_add_product_help_box/shop_add_product_suggest_help_dialog_widget.dart';

class AddProductHelpBoxShop extends StatelessWidget {
  const AddProductHelpBoxShop({super.key});

  @override
  Widget build(BuildContext context) {
    //Lấy addProductController hiện tại
    final addProductController = AddProductController.instance;

    return Obx(() {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 550), //Thời gian chạy animation
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          //Slide animation (dịch xuống)
          final slideAnimation =
              Tween<Offset>(
                begin: const Offset(0, -0.15), //Trượt từ trên xuống
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              );

          //Fade animation (opacity)
          final fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: animation,
              curve: const Interval(
                0.1,
                1.0,
                curve: Curves.easeIn,
              ), //Delay 10% thời gian mới bắt đầu fade
            ),
          );

          return SlideTransition(
            position: slideAnimation, //Di chuyển trước
            child: FadeTransition(
              opacity: fadeAnimation,
              child: child,
            ), //Rồi mới fade vào
          );
        },
        child: addProductController.showHelpDialog.value
            ? AddProductSuggestHelpDialogShop(
                key: const ValueKey(1),
                title: 'Need help?',
                message:
                    'Having trouble while creating your first product? Contact our support team for assistance.',
                onPrimaryPressed: () {
                  print('Support clicked');
                },
                onSecondaryPressed: addProductController.hideHelpDialog,
              )
            : AddProductHelpCollapsedShop(key: ValueKey(2)),
      );
    });
  }
}
