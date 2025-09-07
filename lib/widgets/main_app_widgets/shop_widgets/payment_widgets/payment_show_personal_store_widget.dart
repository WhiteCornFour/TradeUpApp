import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/user_model.dart';
import 'package:tradeupapp/screens/main_app/shop/personal.dart';
import 'package:tradeupapp/widgets/general/general_snackbar_helper.dart';

class ShowPersonalStorePayment extends StatelessWidget {
  final UserModel data;
  const ShowPersonalStorePayment({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 45,
        height: 45,
        child: Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: data.avtURL == null
                ? Image.asset(
                    'assets/images/logo.png',
                    width: 45,
                    height: 45,
                    fit: BoxFit.fill,
                  )
                : Image.network(
                    data.avtURL!,
                    fit: BoxFit.fill,
                    width: 45,
                    height: 45,
                  ),
          ),
        ),
      ), // Icon cửa hàng
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data.fullName ?? "Loading...",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto-Medium',
              fontSize: 16,
              color: AppColors.header,
            ),
          ),
          SizedBox(width: 4),
          Icon(Icons.verified, color: Colors.green, size: 16),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              data.address ?? "Loading...",
              style: TextStyle(
                fontFamily: 'Roboto-Regular',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.header,
              ),
              softWrap: true,
              maxLines: 2,
            ),
          ),
        ],
      ),
      trailing: Icon(Icons.chevron_right, color: AppColors.background),
      onTap: () {
        if (data.userId == null) {
          SnackbarHelperGeneral.showCustomSnackBar(
            "Please try again!",
            backgroundColor: Colors.orange,
          );
        } else {
          Get.to(Personal(idUser: data.userId!));
        }
      },
    );
  }
}
