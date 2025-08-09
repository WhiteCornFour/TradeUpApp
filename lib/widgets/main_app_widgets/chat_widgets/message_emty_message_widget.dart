import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class EmtyMessage extends StatelessWidget {
  final String imageURL;
  final String fullname;
  const EmtyMessage({super.key, required this.imageURL, required this.fullname});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: imageURL != ''
                    ? NetworkImage(imageURL)
                    : AssetImage('assets/images/avatar-user.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            fullname,
            style: TextStyle(
              color: AppColors.header,
              fontFamily: 'Roboto-Medium',
              fontSize: 27,
            ),
          ),
          Text(
            'Start the conversation!',
            style: TextStyle(
              color: AppColors.header,
              fontFamily: 'Roboto-Regular',
              fontSize: 17,
            ),
          ),
          Text(
            'No messages yet. Say hi 👋',
            style: TextStyle(
              color: AppColors.header,
              fontFamily: 'Roboto-Regular',
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
