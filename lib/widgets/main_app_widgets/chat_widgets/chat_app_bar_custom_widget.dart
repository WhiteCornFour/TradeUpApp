import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class AppBarCustomChat extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustomChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // màu bóng
            offset: Offset(0, 4), // dịch xuống 4px (0 là ngang, 4 là dọc)
            blurRadius: 6, // độ mờ
            spreadRadius: 0, // độ lan
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        spacing: 50,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back_ios, color: AppColors.header),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "Ngo Hoang Nam",
                      style: TextStyle(
                        color: AppColors.header,
                        fontFamily: 'Roboto-Medium',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      'Online',
                      style: TextStyle(
                        color: AppColors.header,
                        fontFamily: 'Roboto-Regular',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.call_outlined,
                  color: AppColors.header,
                  size: 25,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.videocam_outlined,
                  color: AppColors.header,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
