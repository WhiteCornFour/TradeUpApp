import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tradeupapp/constants/app_colors.dart';

import 'package:tradeupapp/screens/main_app/profile/report/controller/report_controller.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';
import 'package:tradeupapp/widgets/general/general_custom_dialog.dart';

import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/report_widgets/report_submit_button_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/report_widgets/report_text_field_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/report_widgets/report_upload_list_image_widget.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final reportController = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButtonCustomGeneral(),
                    const Text(
                      'Report',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40),
                Center(
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/report.png'),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Text(
                  'Something’s Not Right? Let Us Know',
                  style: TextStyle(
                    color: AppColors.header,
                    fontSize: 20,
                    fontFamily: 'Roboto-Black',
                  ),
                ),

                Text(
                  'Report this user if you notice any suspicious or harmful behavior.',
                  style: TextStyle(
                    color: AppColors.header,
                    fontSize: 15,
                    fontFamily: 'Roboto-Medium',
                  ),
                ),

                SizedBox(height: 20),
                TextFieldReport(
                  label: 'Enter your feedback...',
                  controller: reportController.contentFeedBackController,
                  maxLength: 250,
                  maxLines: 10,
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tagname to Report (if any)',
                        style: TextStyle(
                          color: AppColors.header,
                          fontSize: 17,
                          fontFamily: 'Roboto-Medium',
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFieldReport(
                        label: 'Tagname target...',
                        controller: reportController.tagnameTargetController,
                        maxLength: 16,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),

                Obx(
                  () => UploadImageReport(
                    onPressed: () => reportController.showBottomSheet(context),
                    imageList: reportController.imageList,
                    numberImageUploaded: reportController.imageList.length,
                  ),
                ),

                SizedBox(height: 20),
                ButtomSubmitReport(
                  onPressed: () {
                    CustomDialogGeneral.show(
                      context,
                      'Confirm Report Submission',
                      'Do you want to proceed with submitting this report?\nOur team will review it as soon as possible.',
                      () {
                        reportController.handleSubmitReport(context);
                      },
                      numberOfButton: 2,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
