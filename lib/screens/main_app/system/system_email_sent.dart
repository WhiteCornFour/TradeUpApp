import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';
import 'package:tradeupapp/widgets/main_app_widgets/email_sent_widgets/email_sent_bottom_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/email_sent_widgets/email_sent_open_gmail_button_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/email_sent_widgets/email_sent_skip_button_widget.dart';

class EmailSent extends StatefulWidget {
  const EmailSent({super.key, required this.destination});
  final Widget destination;
  @override
  State<EmailSent> createState() => _EmailSentState();
}

class _EmailSentState extends State<EmailSent> {
  void _previousScreen() {
    Navigator.of(context).pop();
  }

  void _changeToOtherScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget.destination),
    );
  }

  void _handleOpenGmailApp() async {
    // final Uri params = Uri(scheme: 'mailto');
    // final url = params.toString();
    // launch(url);
    _changeToOtherScreen();
    launch("https://mail.google.com/mail/u/0/#inbox");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 50),
                      Container(
                        height: 200,
                        width: 300,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'lib/assets/images/emailsent.jpg',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.all(30),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 240, 240, 240),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Check your email',
                              style: TextStyle(
                                color: AppColors.header,
                                fontSize: 28,
                                fontFamily: 'Roboto-Black',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Instructions have been sent to your email.\nPlease check your inbox.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.header,
                                fontSize: 15,
                                fontFamily: 'Roboto-Medium',
                              ),
                            ),
                            const SizedBox(height: 25),
                            OpenGmailButtonEmailSent(func: _handleOpenGmailApp),
                            const SizedBox(height: 10),
                            //Skip button
                            SkipButtonEmailSent(
                              onPressed: _changeToOtherScreen,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Change email button
                  BottomEmailSent(onPressed: _previousScreen),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
