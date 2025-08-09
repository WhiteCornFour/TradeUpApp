import 'package:flutter/material.dart';

class AppBarChatRoom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 20,
      automaticallyImplyLeading: false, // Ẩn nút back mặc định nếu không cần
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "messenger",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto-Medium',
              fontSize: 26,
            ),
          ),
          Container(
            height: 38,
            width: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/logo-transparent.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
