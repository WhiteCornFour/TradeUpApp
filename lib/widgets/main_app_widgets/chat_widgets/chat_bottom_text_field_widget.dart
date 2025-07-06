import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';

class BottomTextFieldChat extends StatelessWidget {
  const BottomTextFieldChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          // Ô nhập tin nhắn
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 225, 225, 225),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                style: TextStyle(
                  color: AppColors.header,
                  fontFamily: 'Roboto-Regular',
                ),
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Message...",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Roboto-Regular',
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Nút thêm (ví dụ icon thêm ảnh)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_photo_alternate_outlined, size: 30),
              color: AppColors.header, // nếu có màu chính riêng
            ),
          ),

          const SizedBox(width: 8),

          // Nút gửi tin nhắn
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 225, 225, 225),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send),
              color: AppColors.header, // nếu có màu chính riêng
            ),
          ),
        ],
      ),
    );
  }
}
