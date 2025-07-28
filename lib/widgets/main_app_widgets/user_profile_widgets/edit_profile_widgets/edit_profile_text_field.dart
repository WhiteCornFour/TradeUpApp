import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class TextFieldEditProfile extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final VoidCallback? onIconPressed;
  final bool enabled; // ✅ Thuộc tính mới
  final TextInputType? textInputType;
  const TextFieldEditProfile({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.suffixIcon,
    this.onIconPressed,
    this.enabled = true, // ✅ Mặc định cho phép nhập
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.header,
              fontSize: 15,
              fontFamily: 'Roboto-Regular',
            ),
          ),
          SizedBox(height: 3),
          TextField(
            controller: controller,
            enabled: enabled, // ✅ Truyền vào đây
            //Loai du lieu nhap vao
            keyboardType: textInputType,         
            cursorColor: Colors.black,
            style: TextStyle(
              color: AppColors.header,
              fontSize: 15,
              fontFamily: 'Roboto-Regular',
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 144, 144, 144),
                fontSize: 15,
                fontFamily: 'Roboto-Regular',
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 232, 232, 232),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                // ✅ Bo góc khi bị disabled
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 200, 200, 200),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: AppColors.header, width: 1.5),
              ),
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      icon: Icon(suffixIcon, color: AppColors.header, size: 25),
                      onPressed: onIconPressed,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
