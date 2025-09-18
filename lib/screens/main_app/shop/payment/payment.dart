import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/card_model.dart';
import 'package:tradeupapp/models/offer_details_model.dart';
import 'package:tradeupapp/models/offer_model.dart';
import 'package:tradeupapp/screens/main_app/profile/profile.dart';
import 'package:tradeupapp/screens/main_app/shop/payment/controller/payment_controller.dart';
import 'package:tradeupapp/widgets/general/general_custom_dialog.dart';
import 'package:tradeupapp/widgets/general/general_loading_screen.dart';
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
  late final PaymentController paymentController;
  CardModel? card;

  @override
  void initState() {
    super.initState();
    paymentController = Get.put(PaymentController());
  }

  // Hiển thị 4 số cuối của thẻ (nếu đủ dài)
  String getMaskedCardNumber(String? cardNumber) {
    if (cardNumber == null || cardNumber.isEmpty) return "";
    if (cardNumber.length <= 4) return cardNumber;
    return "**** ${cardNumber.substring(cardNumber.length - 4)}";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (paymentController.idLoading.value) {
        return const LoadingScreenGeneral(
          message: "Waiting for a few seconds...",
        );
      }

      return Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: AppBarPayment(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // hien thi dia chi cua current user
                ShowAddressPayment(
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
                ),

                const SizedBox(height: 10),

                // hien thi lai thong tin san pham
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // màu bóng
                        spreadRadius: 1, // độ lan của bóng
                        blurRadius: 8, // độ mờ
                        offset: const Offset(
                          0,
                          4,
                        ), // dịch xuống dưới (x: ngang, y: dọc)
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Show thong tin cua cua hang
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

                      // border duoi chu
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        height: 1.5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.backgroundGrey,
                        ),
                      ),

                      // Show cac thong tin lien quan den san pham hien tai
                      FutureBuilder(
                        future: paymentController.db.getProductById(
                          widget.offer.productId!,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                // padding: EdgeInsets.symmetric(vertical: 10),
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
                            return const Center(
                              child: Text(
                                "Try again later",
                                style: TextStyle(
                                  color: AppColors.header,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto-Regular',
                                ),
                              ),
                            );
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

                // Chon phuong thuc thanh toan
                TabBarPayment(
                  idCurrentUser: paymentController.idCurrentUser,
                  cards: paymentController.cards,
                  amount: widget.offer.offerPrice!,
                  onCardSelected: (selectedCard) => card = selectedCard,
                  offerId: widget.offer.offerId!,
                  productId: widget.offer.productId!,
                  productOwnerId: widget.offer.receiverId!,
                ),

                // Xac nhan thanh toan
                ButtonCreateOrderPayment(
                  onPressed: () {
                    // print("CardId: $cardId");
                    if (card != null) {
                      final offerDetail = OfferDetailsModel(
                        idUserCheckout: paymentController.idCurrentUser,
                        totalPayment: widget.offer.offerPrice,
                        createdAt: Timestamp.now(),
                        paymentMethod: 0, // 0: Credit Card, 1: Paypal
                        cardId: card!.idCard!,
                        status: 0,
                      );

                      CustomDialogGeneral.show(
                        context,
                        "Confirm Your Payment",
                        "You are about to make a payment\n"
                            "Payment method: ${card!.cardType}\n"
                            "Card: ${getMaskedCardNumber(card!.cardNumber)}\n"
                            "Total amount: ${widget.offer.offerPrice}\n\n"
                            "Do you want to proceed with this payment?",
                        () {
                          paymentController.handleAddOfferDetail(
                            widget.offer.offerId!,
                            offerDetail,
                            widget.offer.productId!,
                            widget.offer.receiverId!,
                          );
                          SnackbarHelperGeneral.showCustomSnackBar(
                            "Payment completed successfully!",
                            backgroundColor: Colors.green,
                          );
                        },
                        numberOfButton: 2,
                      );
                    } else {
                      SnackbarHelperGeneral.showCustomSnackBar(
                        "Please select a card!",
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
