import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';

class DialogAddNewCreditCardPayment {
  static void show(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController numberController = TextEditingController();
    final TextEditingController expController = TextEditingController();
    final TextEditingController cvvController = TextEditingController();
    bool saveCard = false;
    bool showCVV = false;

    showDialog(
      context: context,
      barrierDismissible: false, // Không cho đóng khi bấm ngoài
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.backgroundGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          child: StatefulBuilder(
            builder: (context, setState) {
              void showError(String msg) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(msg), backgroundColor: Colors.red),
                );
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      ListTile(
                        leading: BackButtonCustomGeneral(),
                        title: Center(
                          child: Text(
                            "Add Card",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        trailing: SizedBox(width: 10),
                      ),
                      SizedBox(width: 10),

                      // Card Container
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.credit_card, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  "Credit/Debit Card",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Cardholder Name
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: "Cardholder Name",
                                border: OutlineInputBorder(),
                                floatingLabelStyle: TextStyle(
                                  color: AppColors.header,
                                ),
                                labelStyle: const TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.header,
                                    width: 2,
                                  ), // Khi focus
                                ),
                              ),

                              style: TextStyle(
                                color: AppColors.header,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              cursorColor: AppColors.header,
                            ),
                            const SizedBox(height: 12),

                            // Card Number with auto-format #### #### #### ####
                            TextField(
                              controller: numberController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(16),
                                CardNumberFormatter(),
                              ],
                              decoration: InputDecoration(
                                labelText: "Card Number",
                                border: const OutlineInputBorder(),
                                floatingLabelStyle: TextStyle(
                                  color: AppColors.header,
                                ),
                                labelStyle: const TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.header,
                                    width: 2,
                                  ), // Khi focus
                                ),
                              ),
                              style: TextStyle(
                                color: AppColors.header,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              cursorColor: AppColors.header,
                            ),
                            const SizedBox(height: 12),

                            // Expiration + CVV
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    controller: expController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(6),
                                      ExpirationDateFormatter(),
                                    ],
                                    decoration: InputDecoration(
                                      labelText: "Expiration Date",
                                      hintText: "MM/YYYY",
                                      border: const OutlineInputBorder(),
                                      floatingLabelStyle: TextStyle(
                                        color: AppColors.header,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.header,
                                          width: 2,
                                        ), // Khi focus
                                      ),
                                      labelStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: AppColors.header,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    cursorColor: AppColors.header,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    controller: cvvController,
                                    keyboardType: TextInputType.number,
                                    obscureText: !showCVV,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(3),
                                    ],
                                    decoration: InputDecoration(
                                      labelText: "CVV",
                                      border: const OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.header,
                                          width: 2,
                                        ), // Khi focus
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          showCVV
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            showCVV = !showCVV;
                                          });
                                        },
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: AppColors.header,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    cursorColor: AppColors.header,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Checkbox Save
                      Row(
                        children: [
                          Checkbox(
                            value: saveCard,
                            activeColor: AppColors.background,
                            onChanged: (value) {
                              setState(() {
                                saveCard = value ?? false;
                              });
                            },
                          ),
                          const Text(
                            "Save this card for faster payments.",
                            style: TextStyle(
                              color: AppColors.header,
                              fontFamily: 'Roboto-Regular',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Pay Now Button with validate
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (nameController.text.isEmpty) {
                              showError("Cardholder name cannot be empty");
                            } else if (numberController.text
                                    .replaceAll(" ", "")
                                    .length !=
                                16) {
                              showError("Card number must be 16 digits");
                            } else if (!RegExp(
                              r"^(0[1-9]|1[0-2])/\d{4}$",
                            ).hasMatch(expController.text)) {
                              showError("Expiration date must be MM/YYYY");
                            } else if (cvvController.text.length != 3) {
                              showError("CVV must be 3 digits");
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.background,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Pay Now",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.text,
                              fontFamily: 'Roboto-Medium',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// Formatter cho số thẻ #### #### #### ####
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(' ', '');
    String newText = '';
    for (int i = 0; i < digits.length; i++) {
      if (i % 4 == 0 && i != 0) newText += ' ';
      newText += digits[i];
    }
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

// Formatter cho Expiration Date MM/YYYY
class ExpirationDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll('/', '');
    String newText = '';
    for (int i = 0; i < digits.length; i++) {
      if (i == 2) newText += '/';
      newText += digits[i];
    }
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
