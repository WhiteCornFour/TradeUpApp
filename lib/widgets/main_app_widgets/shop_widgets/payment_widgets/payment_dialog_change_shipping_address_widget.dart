import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';


class DialogChangeShippingAddressPayment {
  static Future<String?> show(
    BuildContext context,
    TextEditingController controller,
    String oldAddress,
  ) {
    controller.text = oldAddress;

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: AppColors.header, size: 22),
              const SizedBox(width: 8),
              Text(
                "Change Shipping Address",
                style: TextStyle(
                  color: AppColors.header,
                  fontFamily: 'Roboto-Medium',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "New shipping address",
                  border: const OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(color: AppColors.header),
                  labelStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.header, width: 2),
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
              Text(
                "Please make sure your address is correct for timely delivery.",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontFamily: 'Roboto-Regular',
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context, null), // ❌ không trả về địa chỉ
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.background),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: AppColors.background,
                  fontFamily: 'Roboto-Medium',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final newAddress = controller.text.trim();
                Navigator.pop(context, newAddress); // ✅ trả về địa chỉ
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Confirm",
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 16,
                  fontFamily: 'Roboto-Medium',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

