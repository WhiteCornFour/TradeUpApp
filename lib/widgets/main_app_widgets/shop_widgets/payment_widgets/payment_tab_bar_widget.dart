import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/card_model.dart';
import 'package:tradeupapp/screens/main_app/shop/controllers/payment_controller.dart';
import 'package:tradeupapp/widgets/general/general_custom_dialog.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_bottom_sheet_wallet_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_button_add_credit_card_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_credit_card_item_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_dialog_add_new_credit_card_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_wallet_item_widget.dart';

class TabBarPayment extends StatefulWidget {
  final String idCurrentUser;
  final List<CardModel> cards;
  const TabBarPayment({
    super.key,
    required this.idCurrentUser,
    required this.cards,
  });

  @override
  State<TabBarPayment> createState() => _TabBarPaymentState();
}

class _TabBarPaymentState extends State<TabBarPayment> {
  String _selectedValue = "A"; // State cho radio
  final paymentController = Get.find<PaymentController>();

  void showDialogComfirmDelete(String? idCard) {
    CustomDialogGeneral.show(
      context,
      "Delete Card",
      "Do you want to delete this card?",
      () {
        paymentController.handleDeleteCard(idCard!);
      },
      numberOfButton: 2,
    );
  }

  void showDialogComfirmDeleteTempCard(CardModel card) {
    CustomDialogGeneral.show(
      context,
      "Delete Card",
      "Do you want to delete this card?",
      () {
        paymentController.tempCards.remove(card);
      },
      numberOfButton: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double tabViewHeight = MediaQuery.of(context).size.height * 0.35;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DefaultTabController(
            length: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TabBar
                TabBar(
                  dividerHeight: 0,
                  indicatorColor: AppColors.background,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColors.background,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(icon: Icon(Icons.credit_card), text: 'Card'),
                    Tab(
                      icon: Icon(Icons.account_balance_wallet),
                      text: 'Wallet',
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // TabBarView
                SizedBox(
                  height: tabViewHeight,
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Tab 1: Cards
                      Obx(() {
                        final allCards = [
                          ...paymentController.cards,
                          ...paymentController.tempCards,
                        ];
                        return ListView.builder(
                          itemCount: allCards.length + 1,
                          itemBuilder: (context, index) {
                            if (index < allCards.length) {
                              final card = allCards[index];
                              return CreditCardItemPayment(
                                card: card,
                                onLongPressed: () {
                                  if (paymentController.cards.contains(card)) {
                                    showDialogComfirmDelete(card.idCard);
                                  } else {
                                    // Xóa card tạm
                                    showDialogComfirmDeleteTempCard(card);
                                  }
                                },
                                selectedValue: _selectedValue,
                                value: card.idCard ?? "",
                                onChanged: (val) {
                                  setState(() {
                                    _selectedValue = val!;
                                  });
                                },
                              );
                            } else {
                              return ButtonAddCreditCardPayment(
                                onPressedAddNew: () async {
                                  final card =
                                      await DialogAddNewCreditCardPayment.show(
                                        context,
                                      );
                                  if (card != null) {
                                    final positionSaveCard = card.status == 1
                                        ? true
                                        : false;
                                    paymentController.handleAddCard(
                                      card,
                                      saveToDb: positionSaveCard,
                                    );
                                  }
                                },
                              );
                            }
                          },
                        );
                      }),

                      // Tab 2: Wallets
                      ListView(
                        children: [
                          WalletItemPayment(
                            walletName: 'PayPal',
                            walletImage: 'paypal.png',
                            walletStatus: "Not linked yet",
                            onPressed: () {
                              BottomSheetWalletPayment.show(context);
                            },
                          ),
                          WalletItemPayment(
                            walletName: 'MoMo',
                            walletImage: 'MoMo.jpg',
                            onPressed: () {
                              //BottomSheetWalletPayment.show(context);
                            },
                          ),
                          WalletItemPayment(
                            walletName: 'ZaloPay',
                            walletImage: 'zalopay.png',
                            onPressed: () {
                              //BottomSheetWalletPayment.show(context);
                            },
                          ),
                          WalletItemPayment(
                            walletName: 'VnPay',
                            walletImage: 'vnpay.png',
                            onPressed: () {
                              //BottomSheetWalletPayment.show(context);
                            },
                          ),
                          WalletItemPayment(
                            walletName: 'Viettel Money',
                            walletImage: 'viettelmoney.jpg',
                            onPressed: () {
                              //BottomSheetWalletPayment.show(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
