import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';
class NoChatFoundChatRoom extends StatelessWidget {
  const NoChatFoundChatRoom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/communicate.png',
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Text(
            'No chats found.',
            style: TextStyle(
              color: AppColors.header,
              fontFamily: 'Roboto-Medium',
              fontSize: 17,
            ),
          ),
          const Text(
            'Find someone and say hello!',
            style: TextStyle(
              color: AppColors.header,
              fontFamily: 'Roboto-Medium',
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}