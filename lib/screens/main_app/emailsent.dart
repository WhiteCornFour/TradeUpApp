import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';

class EmailSent extends StatefulWidget {
  const EmailSent({super.key});

  @override
  State<EmailSent> createState() => _EmailSentState();
}

class _EmailSentState extends State<EmailSent> {
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
                        margin: const EdgeInsets.all(15),
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
                            MaterialButton(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 45,
                                vertical: 15,
                              ),
                              color: AppColors.header,
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Open email app',
                                style: TextStyle(
                                  color: AppColors.text,
                                  fontSize: 18,
                                  fontFamily: 'Roboto-Medium',
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Skip, I\'ll change later',
                                style: TextStyle(
                                  color: AppColors.background,
                                  fontFamily: 'Roboto-Regular',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Did not receive the email? Check your spam filter,',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('or '),
                          TextButton(
                            onPressed: () {},
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
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}