import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_bottom_sheet_wallet_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_button_add_credit_card_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_credit_card_item_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_dialog_add_new_credit_card_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_wallet_item_widget.dart';

class TabBarPayment extends StatefulWidget {
  const TabBarPayment({super.key});

  @override
  State<TabBarPayment> createState() => _TabBarPaymentState();
}

class _TabBarPaymentState extends State<TabBarPayment> {
  String _selectedValue = "A"; // State cho radio
  final int _cardCount = 10; // giả lập số lượng thẻ, sau này load từ API

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

                // TabBarView với chiều cao động
                SizedBox(
                  height: tabViewHeight, // Có thể bỏ nếu muốn auto fit
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Tab 1: Dùng ListView cho cả danh sách + nút thêm
                      ListView.builder(
                        itemCount: _cardCount + 1, // +1 để thêm nút cuối
                        itemBuilder: (context, index) {
                          if (index < _cardCount) {
                            return CreditCardItemPayment(
                              selectedValue: _selectedValue,
                              value: "Card$index",
                              onChanged: (val) {
                                setState(() {
                                  _selectedValue = val!;
                                });
                              },
                            );
                          } else {
                            return ButtonAddCreditCardPayment(
                              onPressedAddNew: () {
                                DialogAddNewCreditCardPayment.show(context);
                              },
                            );
                          }
                        },
                      ),

                      // Tab 2: Ví
                      ListView(
                        children: [
                          WalletItemPayment(
                            walletName: 'MoMo',
                            walletImage: 'MoMo.jpg',
                            onPressed: () {
                              BottomSheetWalletPayment.show(context);
                            },
                          ),
                          WalletItemPayment(
                            walletName: 'ZaloPay',
                            walletImage: 'zalopay.png',
                            onPressed: () {
                              BottomSheetWalletPayment.show(context);
                            },
                          ),
                          WalletItemPayment(
                            walletName: 'VnPay',
                            walletImage: 'vnpay.png',
                            onPressed: () {
                              BottomSheetWalletPayment.show(context);
                            },
                          ),
                          WalletItemPayment(
                            walletName: 'Viettel Money',
                            walletImage: 'viettelmoney.jpg',
                            onPressed: () {
                              BottomSheetWalletPayment.show(context);
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
