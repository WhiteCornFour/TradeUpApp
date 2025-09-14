import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/screens/main_app/shop/controllers/shop_controller.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_pop_menu/shop_pop_menu_item.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_pop_menu/shop_pop_menu_items_list.dart';

class PopMenuShop extends StatelessWidget {
  const PopMenuShop({super.key});

  @override
  Widget build(BuildContext context) {
    final shopController = Get.find<ShopController>();
    return PopupMenuButton<PopMenuItemShop>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      offset: Offset(0, 45),
      color: Colors.white,
      elevation: 6,
      tooltip: 'Sort Menu',
      icon: Icon(Iconsax.menu_1, color: Colors.black),
      onSelected: (PopMenuItemShop item) {
        if (item.text == 'Newest') {
          shopController.handleFilterNewest();
        } else {
          shopController.handleFilterOldest();
        }
      },
      itemBuilder: (BuildContext context) =>
          PopMenuItemsListShop.itemsFirst.map((item) {
            return PopupMenuItem<PopMenuItemShop>(
              value: item,
              child: Row(
                children: [
                  Icon(item.icon, color: Colors.black54, size: 20),
                  SizedBox(width: 10),
                  Text(
                    item.text,
                    style: TextStyle(
                      fontFamily: 'Roboto-Medium',
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
