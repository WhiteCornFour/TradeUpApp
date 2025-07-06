import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';

class ItemMessageChat extends StatelessWidget {
  const ItemMessageChat({
    super.key,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    this.topRight = 12,
    this.topLeft = 12,
  });

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double topRight;
  final double topLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Column(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:
                      MediaQuery.of(context).size.width * 0.7, // Giới hạn 70%
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.header,
                        blurRadius: 2,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                    color: AppColors.header,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(topRight),
                      bottomRight: const Radius.circular(12),
                      bottomLeft: const Radius.circular(12),
                      topLeft: Radius.circular(topLeft),
                    ),
                  ),
                  child: const Text(
                    "Người A gửi một tin nhắn rất dài mà nếu không giới hạn sẽ bị tràn qua bên kia màn hình",
                    style: TextStyle(
                      color: AppColors.text,
                      fontFamily: 'Roboto-Regular',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10, left: 10, top: 3),
                child: Text(
                  '10:10',
                  style: TextStyle(
                    color: AppColors.header,
                    fontFamily: 'Roboto-Regular',
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
