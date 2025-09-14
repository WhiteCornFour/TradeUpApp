import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class WalletItemPayment extends StatelessWidget {
  final String walletName;
  final String walletImage;
  final Function onPressed;
  final String walletStatus;
  const WalletItemPayment({
    super.key,
    required this.walletName,
    required this.walletImage,
    required this.onPressed,
    this.walletStatus = "Comming soon",
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.backgroundGrey, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/$walletImage',
              height: 50,
              width: 50,
            ),
          ),
          title: Text(
            walletName,
            style: TextStyle(
              color: AppColors.header,
              fontFamily: 'Roboto-Regular',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            walletStatus,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: 'Roboto-Regular',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.header),
        ),
      ),
    );
  }
}
