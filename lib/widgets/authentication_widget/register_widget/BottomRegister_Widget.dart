import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/AppColors.dart';

class BottomRegister_Widget extends StatelessWidget {
  const BottomRegister_Widget({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account?",
            style: TextStyle(
              fontSize: 14,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontFamily: 'Roboto-Regular',
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              "Sign In",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto-Bold',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
