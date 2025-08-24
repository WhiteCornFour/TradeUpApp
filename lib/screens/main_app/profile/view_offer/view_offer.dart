import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/view_offer_widgets/user_profile_view_offer_received_offer_card_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/view_offer_widgets/user_profile_view_offer_sent_offer_card_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/view_offer_widgets/user_profile_view_offer_tab_item_widget.dart';

class ViewOffer extends StatelessWidget {
  const ViewOffer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> offers = [
      {
        "productImage": "assets/images/sample_images/sample4.jpg",
        "productName": "JBL",
        "offerPrice": 120.0,
        "status": "pending",
      },
      {
        "productImage": "assets/images/sample_images/sample2.jpg",
        "productName": "JBL 2.0",
        "offerPrice": 45.5,
        "status": "accepted",
      },
      {
        "productImage": "assets/images/sample_images/sample3.jpg",
        "productName": "Old JBL",
        "offerPrice": 300.0,
        "status": "rejected",
      },
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              //Header
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

              //TabBar
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
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: const Color.fromARGB(255, 210, 235, 255),
                    ),
                    child: const TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black54,
                      tabs: [
                        ViewOfferTabItemUserProfile(
                          title: 'Received',
                          count: 10,
                        ),
                        ViewOfferTabItemUserProfile(title: 'Sent', count: 5),
                      ],
                    ),
                  ),
                ),
              ),

              //Tab content
              Expanded(
                child: TabBarView(
                  children: [
                    //Tab 1: Offer nhận được
                    ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                      physics: const BouncingScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return ViewOfferReceivedOfferCardUserProfile(
                          productName: "Nike Air Force $index",
                          productImage:
                              "assets/images/sample_images/sample2.jpg",
                          offerUser: "John Doe",
                          originPrice: 150.0,
                          offerPrice: index.isEven ? 170.0 : 120.0,
                          onAccept: () {
                            debugPrint("Accepted offer $index");
                          },
                          onDecline: () {
                            debugPrint("Declined offer $index");
                          },
                        );
                      },
                    ),

                    //Tab 2: Offer đã gửi
                    ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: offers.length,
                      itemBuilder: (context, index) {
                        final offer = offers[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ViewOfferSentOfferCardUserProfile(
                            productImage: offer["productImage"],
                            productName: offer["productName"],
                            offerPrice: offer["offerPrice"],
                            status: offer["status"],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
