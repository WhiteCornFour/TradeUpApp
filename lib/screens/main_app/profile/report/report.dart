import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';
import 'package:tradeupapp/utils/back_button.dart';
import 'package:tradeupapp/widgets/main_app_widgets/user_profile_widgets/report_widgets/report_text_field_widget.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    controller.clear();
    super.dispose();
  }

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
                    BackButtonCustom(),
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
                        image: AssetImage('lib/assets/images/report.png'),
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
                  controller: controller,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(
                            'lib/assets/images/noimageavailable.png',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    MaterialButton(
                      color: AppColors.header,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(20),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Upload Now',
                        style: TextStyle(
                          color: AppColors.text,
                          fontFamily: 'Roboto-Black',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: MaterialButton(
                    color: AppColors.background,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20),
                    ),
                    onPressed: () {},
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Submit this report',
                          style: TextStyle(
                            color: AppColors.text,
                            fontFamily: 'Roboto-Black',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
