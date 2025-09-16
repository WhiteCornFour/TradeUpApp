import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/card_model.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class CreditCardItemPayment extends StatelessWidget {
  final String selectedValue;
  final String value;
  final ValueChanged<String?> onChanged;
  final CardModel card;
  final Function onLongPressed;

  const CreditCardItemPayment({
    super.key,
    required this.selectedValue,
    required this.value,
    required this.onChanged,
    required this.card,
    required this.onLongPressed,
  });

  @override
  Widget build(BuildContext context) {
    //Danh sách các loại thẻ
    List<Map<String, dynamic>> items = [
      {"name": "MasterCard", "image": "assets/images/mastercard.png"},
      {"name": "Visa", "image": "assets/images/visa.png"},
      {
        "name": "American Express",
        "image": "assets/images/americanexpress.png",
      },
      {"name": "JCB", "image": "assets/images/jcb.png"},
    ];

    // Hiển thị 4 số cuối của thẻ (nếu đủ dài)
   String getMaskedCardNumber(String? cardNumber) {
      if (cardNumber == null || cardNumber.isEmpty) return "";
      if (cardNumber.length <= 4) return cardNumber;
      return "**** ${cardNumber.substring(cardNumber.length - 4)}";
    }

    // Hàm lấy logo thẻ dựa vào cardType
    String getImageCardType(String cardType) {
      for (var type in items) {
        if (type["name"] == cardType) {
          return type["image"];
        }
      }
      return "assets/images/noimageavailable.png"; // fallback nếu không match
    }

    return MaterialButton(
      minWidth: 0,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onPressed: () {
        SnackbarHelperGeneral.showCustomSnackBar(
          "Please hold to delete this card!",
          backgroundColor: Colors.orange,
        );
      },
      onLongPress: () {
        onLongPressed();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.backgroundGrey, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Logo + Card holder name
            Expanded(
              child: Row(
                children: [
                  Image.asset(
                    getImageCardType(card.cardType!),
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      card.cardHolderName ?? "Loading...",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.header,
                        fontFamily: 'Roboto-Regular',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 4 số cuối
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                getMaskedCardNumber(card.cardNumber),
                style: const TextStyle(
                  color: AppColors.header,
                  fontFamily: 'Roboto-Regular',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Radio button
            Radio<String>(
              value: value,
              groupValue: selectedValue,
              activeColor: AppColors.background,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
