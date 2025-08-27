import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/screens/main_app/shop/personal.dart';

class ShowPersonalStorePayment extends StatelessWidget {
  final String idUserPersonal;
  const ShowPersonalStorePayment({super.key, required this.idUserPersonal});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 30,
        height: double.infinity,
        child: Align(
          alignment: Alignment.topCenter,
          child: ClipOval(
            child: Image.asset(
              'assets/images/logo.png',
              width: 30,
              height: 30,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ), // Icon cửa hàng
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Wonwoo Store",
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
              'Ap Cau Tre, Xa Long Thoi, Huyen Tieu Can, Tinh Tra Vinh',
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
        Get.to(Personal(idUser: idUserPersonal));
      },
    );
  }
}
