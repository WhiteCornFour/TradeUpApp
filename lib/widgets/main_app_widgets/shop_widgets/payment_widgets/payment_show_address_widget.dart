import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class ShowAddressPayment extends StatelessWidget {
  final Function onPressedIconButton;
  final String shippingAdress;
  const ShowAddressPayment({super.key, required this.onPressedIconButton, required this.shippingAdress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // màu bóng
                spreadRadius: 1, // độ lan của bóng
                blurRadius: 8, // độ mờ
                offset: Offset(0, 4), // dịch xuống dưới (x: ngang, y: dọc)
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping Address',
                    style: TextStyle(
                      color: AppColors.header,
                      fontFamily: 'Roboto-Medium', // sửa chính tả
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      onPressedIconButton();
                    },
                    icon: Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.background,
                    ),
                  ),
                ],
              ),

              //border duoi chu
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                height: 1.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.backgroundGrey,
                ),
              ),

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // canh text từ trên
                children: [
                  Icon(Icons.location_on, color: AppColors.background),
                  SizedBox(width: 8), // tạo khoảng cách icon - text
                  Expanded(
                    child: Text(
                      shippingAdress,
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        color: AppColors.header,
                        fontFamily: 'Roboto-Regular',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
