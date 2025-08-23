import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/payment_widgets/payment_show_address_widget.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        leading: BackButtonCustomGeneral(),
        backgroundColor: AppColors.backgroundGrey,
        centerTitle: true,
        title: Text(
          'Checkout',
          style: TextStyle(
            color: AppColors.header,
            fontFamily: 'Roboto-Medium',
            fontSize: 23,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //hien thi dia chi cua current user
              ShowAddressPayment(),

              SizedBox(height: 15),
              //hien thi lai thong tin san pham
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // màu bóng
                      spreadRadius: 1, // độ lan của bóng
                      blurRadius: 8, // độ mờ
                      offset: Offset(
                        0,
                        4,
                      ), // dịch xuống dưới (x: ngang, y: dọc)
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 30,
                              height: 30,
                            ),
                          ),
                          SizedBox(height: 5),
                          Icon(Icons.location_on, size: 20, color: Colors.grey),
                        ],
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
                      trailing: Icon(
                        Icons.chevron_right,
                        color: AppColors.header,
                      ),
                      onTap: () {
                        // Xử lý khi nhấn vào item
                      },
                    ),

                    //border duoi chu
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 10,
                        top: 10,
                        left: 20,
                        right: 20,
                      ),
                      height: 1.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.backgroundGrey,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sony Headphones 6',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.header,
                                    fontFamily: 'Roboto-Medium',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Mô tả sản phẩm Mô tả sản phẩm Mô tả sản phẩm Mô tả sản phẩm',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.header,
                                    fontFamily: 'Roboto-Regular',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '25.000Đ',
                            style: TextStyle(
                              color: AppColors.header,
                              fontFamily: 'Roboto-Medium',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
