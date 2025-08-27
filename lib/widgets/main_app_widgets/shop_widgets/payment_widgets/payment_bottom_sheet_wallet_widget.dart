import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class BottomSheetWalletPayment {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Chiều cao vừa đủ nội dung
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Wallet Options",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto-Medium',
                    color: AppColors.header,
                  ),
                ),
                const SizedBox(height: 16),
                MaterialButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child: const ListTile(
                    leading: Icon(Icons.link, color: Colors.deepPurple),
                    title: Text(
                      "Link Wallet",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto-Regular',
                        color: AppColors.header,
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child: const ListTile(
                    leading: Icon(Icons.link_off, color: Colors.redAccent),
                    title: Text(
                      "Unlink Wallet",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto-Regular',
                        color: AppColors.header,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
