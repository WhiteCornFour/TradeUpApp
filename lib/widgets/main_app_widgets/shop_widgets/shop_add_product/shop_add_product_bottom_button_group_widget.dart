import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/widgets/general/general_button_widget.dart';

class AddProductWizardNavigationButtonsShop extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final VoidCallback? onFinish;
  final VoidCallback? onBackHome;
  final VoidCallback? onManageProducts;

  const AddProductWizardNavigationButtonsShop({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.onNext,
    this.onBack,
    this.onFinish,
    this.onBackHome,
    this.onManageProducts,
  });

  @override
  Widget build(BuildContext context) {
    bool isFirstStep = currentStep == 0;
    bool isSecondStep = currentStep == 1;
    bool isThirdStep = currentStep == 2;
    bool isLastStep = currentStep == totalSteps - 1; // step 4

    return Row(
      children: [
        //Back to Home và My Page (Step 4)
        if (isLastStep) ...[
          //Back to Home
          Expanded(
            child: ButtonGeneral(
              text: "Back to Home",
              backgroundColor: AppColors.header,
              onPressed: onBackHome,
              isOutlined: true,
            ),
          ),
          const SizedBox(width: 8),
          //My Page
          Expanded(
            child: ButtonGeneral(
              text: "My Page",
              backgroundColor: AppColors.background,
              onPressed: onManageProducts,
            ),
          ),
        ] else if (isFirstStep) ...[
          //Chỉ hiện Next (Step 1)
          Expanded(
            child: ButtonGeneral(
              text: "Next",
              backgroundColor: AppColors.background,
              onPressed: onNext,
            ),
          ),
        ] else if (isSecondStep) ...[
          //Back + Next (Step 2)
          Expanded(
            child: ButtonGeneral(
              text: "Back",
              isOutlined: true,
              backgroundColor: AppColors.header,
              onPressed: onBack,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ButtonGeneral(
              text: "Next",
              backgroundColor: AppColors.background,
              onPressed: onNext,
            ),
          ),
        ] else if (isThirdStep) ...[
          //Back + Finish (Step 3)
          Expanded(
            child: ButtonGeneral(
              text: "Back",
              isOutlined: true,
              backgroundColor: AppColors.header,
              onPressed: onBack,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ButtonGeneral(
              text: "Finish",
              backgroundColor: AppColors.background,
              onPressed: onFinish,
            ),
          ),
        ],
      ],
    );
  }
}
