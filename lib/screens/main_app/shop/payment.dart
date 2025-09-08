import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/offer_model.dart';
import 'package:tradeupapp/screens/main_app/shop/controllers/payment_controller.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_app_bar_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_button_create_order_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_dialog_change_shipping_address_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_show_address_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_show_infor_product_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_show_personal_store_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_tab_bar_widget.dart';

class Payment extends StatefulWidget {
  const Payment({super.key, required this.offer});

  final OfferModel offer;
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late PaymentController paymentController;

  @override
  void initState() {
    super.initState();
    paymentController = Get.put(PaymentController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBarPayment(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //hien thi dia chi cua current user
              Obx(() {
                return ShowAddressPayment(
                  shippingAdress: paymentController.shippingAddress.value,
                  onPressedIconButton: () async {
                    final result =
                        await DialogChangeShippingAddressPayment.show(
                          context,
                          paymentController.newAddressController,
                          paymentController.shippingAddress.value,
                        );

                    if (result != null && result.isNotEmpty) {
                      paymentController.shippingAddress.value = result;
                      paymentController.handleUpdateShippingAdress();
                      SnackbarHelperGeneral.showCustomSnackBar(
                        "Update shipping address completed!",
                        backgroundColor: Colors.green,
                      );
                    }
                  },
                );
              }),

              SizedBox(height: 10),
              //hien thi lai thong tin san pham
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // màu bóng
                      spreadRadius: 1, // độ lan của bóng
                      blurRadius: 8, // độ mờ
                      offset: Offset(
                        0,
                        4,
                      ), // dịch xuống dưới (x: ngang, y: dọc)
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Show thong tin cua cua hang
                    FutureBuilder(
                      future: paymentController.db.fetchUserModelById(
                        widget.offer.receiverId!,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: SizedBox(),
                            // child: CircularProgressIndicator(
                            //   padding: EdgeInsets.symmetric(vertical: 10),
                            //   color: AppColors.text,
                            //   backgroundColor: AppColors.background,
                            // ),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Error: ${snapshot.error}",
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(child: Text("No data found"));
                        }

                        final dataStore = snapshot.data!;
                        return ShowPersonalStorePayment(data: dataStore);
                      },
                    ),

                    //border duoi chu
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 10,
                        top: 10,
                        left: 20,
                        right: 20,
                      ),
                      height: 1.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.backgroundGrey,
                      ),
                    ),

                    //Show cac thong tin lien quan den san pham hien tai
                    FutureBuilder(
                      future: paymentController.db.getProductById(
                        widget.offer.productId!,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              color: AppColors.text,
                              backgroundColor: AppColors.background,
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Error: ${snapshot.error}",
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(child: Text("No data found"));
                        }

                        final dataStore = snapshot.data!;
                        return ShowInforProductPayment(
                          controller: paymentController,
                          data: dataStore,
                          totalPrice: widget.offer.offerPrice.toString(),
                        );
                      },
                    ),
                  ],
                ),
              ),

              //Chon phuong thuc thanh toan
              TabBarPayment(
                idCurrentUser: paymentController.idCurrentUser,
                cards: paymentController.cards,
              ),

              //Xac nhan thanh toan
              ButtonCreateOrderPayment(),
            ],
          ),
        ),
      ),
    );
  }
}
