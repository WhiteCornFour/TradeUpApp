import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';

//------------Demo dung Dialog Custom------------------
// class Dialog1 extends StatelessWidget {
//   const Dialog1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     void backFunc() {
//       Navigator.of(context).pop();
//     }

//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.symmetric(vertical: 50),
//         width: double.infinity,
//         color: Colors.amberAccent,
//         child: MaterialButton(
//           onPressed: () {
//             CustomDialog.show(
//               context,
//               'String',
//               'Test',
//               backFunc,
//               image: 'warning.jpg',
//             );
//           },
//           child: Text("Mở hộp thoại"),
//         ),
//       ),
//     );
//   }
// }
class CustomDialog {
  static void show(
    BuildContext context,
    String header,
    String content,
    Function onPressed,
    Function onPressedExtend, {
    String textButton1 = 'Confirm',
    String textButton2 = 'Cancel',
    String image = 'completed.png',
    int numberOfButton = 1,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // ✅ Sửa tại đây
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "lib/assets/images/$image",
                    fit: BoxFit.fill,
                    width: 200,
                    height: 150,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        header,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Roboto-Black',
                          color: AppColors.header,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        content,
                        style: TextStyle(
                          color: AppColors.header,
                          fontFamily: 'Roboto-Regular',
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 16),
                      Stack(
                        children: [
                          numberOfButton == 2
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //Button 1
                                    MaterialButton(
                                      onPressed: () {
                                        onPressed();
                                        Navigator.of(context).pop();
                                      },
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        side: BorderSide(
                                          color: AppColors.background,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        textButton1,
                                        style: TextStyle(
                                          color: AppColors.header,
                                          fontFamily: 'Roboto-Medium',
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    //Button 2
                                    MaterialButton(
                                      onPressed: () {
                                        onPressedExtend();
                                        Navigator.of(context).pop();
                                      },
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      color: AppColors.background,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        textButton2,
                                        style: TextStyle(
                                          color: AppColors.text,
                                          fontFamily: 'Roboto-Medium',
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      onPressed();
                                      Navigator.of(context).pop();
                                    },
                                    shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 100,
                                    ),
                                    color: AppColors.background,
                                    child: Text(
                                      textButton1,
                                      style: TextStyle(
                                        color: AppColors.text,
                                        fontFamily: 'Roboto-Medium',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
