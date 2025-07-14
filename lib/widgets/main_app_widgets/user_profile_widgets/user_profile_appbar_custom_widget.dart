import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';

class AppbarCustomUserProfile extends StatelessWidget
    implements PreferredSizeWidget {
  const AppbarCustomUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 240, 240, 240),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center, // căn giữa theo trục dọc
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: const DecorationImage(
                    image: AssetImage("lib/assets/images/logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10), // khoảng cách giữa avatar và thông tin
              // Thông tin user
              Column(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ngo Hoang Nam',
                    style: TextStyle(
                      color: AppColors.header,
                      fontSize: 16,
                      fontFamily: 'Roboto-Black',
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.background,
                        size: 16,
                      ),
                      Text(
                        'Ho Chi Minh City',
                        style: TextStyle(
                          color: AppColors.header,
                          fontSize: 13,
                          fontFamily: 'Roboto-Regular',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Avatar
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                Colors.white,
              ), // chỉnh màu nền nếu cần
              minimumSize: WidgetStateProperty.all<Size>(
                Size(30, 30),
              ), // chiều rộng tối thiểu
              padding: WidgetStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min, // chỉ chiếm không gian vừa đủ
              children: [
                Icon(Icons.edit_square, color: AppColors.header, size: 16),
                SizedBox(width: 5),
                Text(
                  'Edit',
                  style: TextStyle(
                    color: AppColors.header,
                    fontFamily: 'Roboto-Regular',
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
