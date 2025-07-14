import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';

class CategoryFuncUserProfile extends StatelessWidget {
  const CategoryFuncUserProfile({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
  });

  final VoidCallback onTap; // dùng VoidCallback thay vì Function để an toàn hơn
  final IconData icon; // icon truyền từ ngoài
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            // const Color.fromARGB(255, 240, 240, 240),
            Colors.white,
          ),
          elevation: WidgetStateProperty.all<double>(0),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        onPressed: onTap, // sử dụng hàm truyền vào
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.header,
                  size: 20,
                ), // dùng icon truyền vào
                const SizedBox(width: 10),
                Text(
                  label, // dùng label truyền vào
                  style: TextStyle(
                    color: AppColors.header,
                    fontFamily: 'Roboto-Regular',
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.header,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
