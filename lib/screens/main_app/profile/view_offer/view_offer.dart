import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/profile/view_offer/controller/view_offer_controller.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_product_detail/shop_product_detail.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';
import 'package:tradeupapp/widgets/general/general_loading_screen.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/view_offer_widgets/user_profile_view_offer_received_offer_card_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/view_offer_widgets/user_profile_view_offer_sent_offer_card_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/view_offer_widgets/user_profile_view_offer_tab_item_widget.dart';

class ViewOffer extends StatefulWidget {
  const ViewOffer({super.key});

  @override
  State<ViewOffer> createState() => _ViewOfferState();
}

class _ViewOfferState extends State<ViewOffer> {
  final viewOfferController = Get.put(ViewOfferController());

  @override
  void initState() {
    super.initState();
    //Load offers sau khi UI được build xong
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await viewOfferController.loadOffers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      //1. Trạng thái loading
      if (viewOfferController.isLoading.value) {
        return const Scaffold(
          body: LoadingScreenGeneral(message: "Loading View Offer page..."),
        );
      }

      //2.Tất cả điều kiện check dữ liệu
      if (viewOfferController.receivedList.isEmpty &&
          viewOfferController.sendList.isEmpty) {
        return const Scaffold(
          body: Center(
            child: Text(
              "No offers found!",
              style: TextStyle(
                color: AppColors.header,
                fontFamily: 'Roboto-Black',
                fontSize: 20,
              ),
            ),
          ),
        );
      }

      //3.Hiển thị UI chính
      return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      BackButtonCustomGeneral(),
                      Text(
                        'View Offer',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                // TabBar
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 20,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Container(
                      height: 45,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Color.fromARGB(255, 210, 235, 255),
                      ),
                      child: Obx(() {
                        return TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          indicator: const BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black54,
                          tabs: [
                            ViewOfferTabItemUserProfile(
                              title: 'Received',
                              count: viewOfferController.receivedList.length,
                            ),
                            ViewOfferTabItemUserProfile(
                              title: 'Sent',
                              count: viewOfferController.sendList.length,
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),

                // Tab content
                Expanded(
                  child: TabBarView(
                    children: [
                      // Tab 1: Received
                      Obx(() {
                        final offers = viewOfferController.receivedList;
                        if (offers.isEmpty) {
                          return const Center(
                            child: Text("No received offers"),
                          );
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                          itemCount: offers.length,
                          itemBuilder: (context, index) {
                            final offer = offers[index];
                            return ViewOfferReceivedOfferCardUserProfile(
                              productName:
                                  offer.product?.productName ??
                                  "Unknown product",
                              productImage:
                                  offer.product?.imageList?.first ??
                                  "assets/images/noimageavailable.png",
                              offerUser: offer.senderName ?? "Unknown user",
                              originPrice: offer.price ?? 0,
                              offerPrice: offer.offerPrice ?? 0,
                              status: offer.status ?? 0,
                              onAccept: () =>
                                  viewOfferController.acceptOffer(offer),
                              onDecline: () =>
                                  viewOfferController.declineOffer(offer),
                            );
                          },
                        );
                      }),

                      // Tab 2: Sent
                      Obx(() {
                        final offers = viewOfferController.sendList;
                        if (offers.isEmpty) {
                          return const Center(child: Text("No sent offers"));
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: offers.length,
                          itemBuilder: (context, index) {
                            final offer = offers[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: ViewOfferSentOfferCardUserProfile(
                                productImage:
                                    offer.product?.imageList?.first ??
                                    "assets/images/noimageavailable.png",
                                productName:
                                    offer.product?.productName ??
                                    "Unknown product",
                                offerPrice: offer.offerPrice ?? 0,
                                status: offer.status ?? 0,
                                onTap: () {
                                  print(offer.product!.userId);
                                  if (offer.product != null) {
                                    Get.to(
                                      () => ProductDetailShop(
                                        product: offer.product!,
                                        userId: offer.product!.userId,
                                        // homeController.user.value?.userId,
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
