import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/profile/sales_history/controller/sales_history_controller.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';
import 'package:tradeupapp/widgets/general/general_loading_screen.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/sales_history_widgets/sales_history_card_product_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/sales_history_widgets/sales_history_pop_menu_widget.dart';

class SalesHistory extends StatefulWidget {
  const SalesHistory({super.key});

  @override
  State<SalesHistory> createState() => _SalesHistoryState();
}

class _SalesHistoryState extends State<SalesHistory> {
  SalesHistoryController salesHistoryController = Get.put(
    SalesHistoryController(),
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      salesHistoryController.handleGetProduct();
    });
    super.initState();
  }

  String _formatTimestampToNgayGio(Timestamp? timestamp) {
    if (timestamp == null) return 'Unknown';
    final date = timestamp.toDate().toLocal();
    final ngay = DateFormat('d/M/yyyy').format(date);
    final gio = DateFormat('HH:mm').format(date);
    return '$ngay at $gio';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (salesHistoryController.isLoading.value) {
        return const LoadingScreenGeneral(
          message: "Waiting for a few seconds...",
        );
      }

      final soldProducts = salesHistoryController.soldProducts;

      return Scaffold(
        appBar: AppBar(
          leading: BackButtonCustomGeneral(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.attach_money_outlined,
                size: 25,
                color: AppColors.header,
              ),
              Text(
                "Sales history",
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
              child: PopMenuSalesHistory(controller: salesHistoryController),
            ),
          ],
        ),
        body: SafeArea(
          child: soldProducts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/images/nosaleyet.jpg"),
                        height: 330,
                      ),
                      Text(
                        "No sales yet!",
                        style: TextStyle(
                          color: AppColors.header,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: soldProducts.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final sold = soldProducts[index];
                    final product = sold.product;
                    final offer = sold.offer;

                   

                    return FutureBuilder(
                      future:  salesHistoryController.handleGetDataBuyer(offer.senderId!),
                      builder: (context, asyncSnapshot) {
                        return CardProductSalesProduct(
                          onPressed: () {},
                          imageUrls: product.imageList ?? [],
                          description: product.productDescription ?? '',
                          userName:
                              salesHistoryController.currentUser!.fullName ??
                              'Loading...',
                          timeAgo: _formatTimestampToNgayGio(product.createdAt),
                          likedBy: product.likedBy ?? [],
                          userAvatar:
                              salesHistoryController.currentUser!.avtURL ?? '',
                          userId: product.userId,
                          currentUserId: salesHistoryController.idCurrentUser,
                          productId: product.productId,
                          buyerName:
                              salesHistoryController.buyerName ?? 'Loading...',
                          totalPrice: offer.price?.toString() ?? 'Loading...',
                          buyerAvatar: salesHistoryController.buyerAvt ?? "",
                        );
                      }
                    );
                  },
                ),
        ),
      );
    });
  }
}
