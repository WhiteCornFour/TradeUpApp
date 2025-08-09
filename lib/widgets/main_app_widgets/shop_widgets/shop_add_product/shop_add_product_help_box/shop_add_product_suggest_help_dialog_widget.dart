import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/widgets/general/general_button_widget.dart';

class AddProductSuggestHelpDialogShop extends StatelessWidget {
  const AddProductSuggestHelpDialogShop({
    super.key,
    required this.title,
    required this.message,
    this.backgroundColor,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.all(20),
    this.primaryButtonText = 'Contact virtual assistant',
    this.primaryButtonColor,
    this.primaryButtonFontSize = 12,
    this.secondaryButtonText = 'Dismiss',
    this.secondaryButtonWidth = 100,
    this.secondaryButtonFontSize = 12,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
  });

  final String title;
  final String message;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;

  final String primaryButtonText;
  final Color? primaryButtonColor;
  final double primaryButtonFontSize;
  final VoidCallback? onPrimaryPressed;

  final String secondaryButtonText;
  final double secondaryButtonWidth;
  final double secondaryButtonFontSize;
  final VoidCallback? onSecondaryPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      width: double.infinity,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontFamily: 'Roboto-Bold', fontSize: 18),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ButtonGeneral(
                  text: primaryButtonText,
                  backgroundColor: primaryButtonColor ?? AppColors.background,
                  fontSize: primaryButtonFontSize,
                  height: 48,
                  borderRadius: 10,
                  onPressed: onPrimaryPressed ?? () {},
                ),
              ),
              const SizedBox(width: 8),
              ButtonGeneral(
                text: secondaryButtonText,
                borderRadius: 10,
                fontSize: secondaryButtonFontSize,
                height: 48,
                width: secondaryButtonWidth,
                isOutlined: true,
                backgroundColor: Colors.grey,
                onPressed: onSecondaryPressed ?? () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
