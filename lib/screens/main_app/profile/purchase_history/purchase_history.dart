import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/profile/purchase_history/controller/purchase_history_controller.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';
import 'package:tradeupapp/widgets/general/general_loading_screen.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/purchase_history_widgets/purchase_history_pop_menu_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/purchase_history_widgets/purchase_history_product_card_widget.dart';

class BuyHistory extends StatefulWidget {
  const BuyHistory({super.key});

  @override
  State<BuyHistory> createState() => _BuyHistoryState();
}

class _BuyHistoryState extends State<BuyHistory> {
  PurchaseHistoryController purchaseHistoryController = Get.put(
    PurchaseHistoryController(),
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      purchaseHistoryController.handleGetPurchaseProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (purchaseHistoryController.isLoading.value) {
        return LoadingScreenGeneral(message: "Waiting for a few seconds...");
      }
      return Scaffold(
        appBar: AppBar(
          leading: BackButtonCustomGeneral(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.header,
                size: 22,
              ),
              SizedBox(width: 5),
              Text(
                "Purchase history",
                style: TextStyle(
                  color: AppColors.header,
                  fontFamily: "Roboto-Medium",
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: PopMenuPurchaseHistory(
                controller: purchaseHistoryController,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: purchaseHistoryController.purchaseHistorys.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage("assets/images/nobuy.png")),
                      Text(
                        "No purchases yet!",
                        style: TextStyle(
                          color: AppColors.header,
                          fontSize: 20,
                          fontFamily: "Roboto-Medium",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: purchaseHistoryController.purchaseHistorys.length,
                  itemBuilder: (context, index) {
                    final data =
                        purchaseHistoryController.purchaseHistorys[index];
                    return ProductCardPurchaseHistory(
                      productModel: data.productModel,
                      offerModel: data.offerModel,
                      offerDetailsModel: data.offerDetailsModel,
                    );
                  },
                ),
        ),
      );
    });
  }
}
