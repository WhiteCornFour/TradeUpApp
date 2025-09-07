import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_product_detail/controller/shop_product_detail_controller.dart';
import 'package:tradeupapp/widgets/general/general_custom_app_bar_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_product_detail/shop_product_detail_top_offer_card.dart';

class ShopOfferList extends StatelessWidget {
  const ShopOfferList({super.key});

  @override
  Widget build(BuildContext context) {
    final productDetailController = Get.find<ProductDetailController>();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarGeneral(
        showBackArrow: false,
        backgroundColor: Colors.white,
        leadingIcon: Iconsax.arrow_left_2,
        leadingOnPressed: Get.back,
        title: const Text(
          'All Categories',
          style: TextStyle(fontFamily: 'Roboto-Medium'),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          final offers = productDetailController.offerList;
        
          if (offers.isEmpty) {
            return const Center(
              child: Text(
                "There are no offers for this product yet.\nBe the first to make one!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto-Regular',
                  color: Colors.black54,
                ),
              ),
            );
          }
        
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: offers.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final offer = offers[index];
              return ProductDetailTopOfferCardShop(
                userName: offer.senderName ?? "Unknown User",
                userAvatar: offer.senderAvatar,
                offerPrice: offer.offerPrice,
                offerType: offer.type,
                 status: offer.status,
              );
            },
          );
        }),
      ),
    );
  }
}
