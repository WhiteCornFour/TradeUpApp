import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';

class BottomEmailSent extends StatelessWidget {
  const BottomEmailSent({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Did not receive the email? Check your spam filter,'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('or '),
            TextButton(
              onPressed: onPressed,
              child: Text(
                'try another email address',
                style: TextStyle(
                  color: AppColors.background,
                  fontFamily: 'Roboto-Regular',
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
