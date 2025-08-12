import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class InformationPersonal extends StatelessWidget {
  final String fullname;
  final String tagName;
  final String rating;
  final String bio;
  final String totalReview;
  const InformationPersonal({
    super.key,
    required this.fullname,
    required this.tagName,
    required this.rating,
    required this.bio,
    required this.totalReview,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullname,
                  style: TextStyle(
                    fontFamily: 'Roboto-Medium',
                    fontSize: 19,
                    color: AppColors.header,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  tagName,
                  style: TextStyle(
                    fontFamily: 'Roboto-thin',
                    fontSize: 17,
                    color: AppColors.header,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            Column(
              children: [
                Center(
                  child: Row(
                    children: [
                      rating == '0.0'
                          ? SizedBox()
                          : Text(
                              rating,
                              style: TextStyle(
                                fontFamily: 'Roboto-thin',
                                fontSize: 17,
                                color: AppColors.header,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                      Icon(Icons.star_rate, color: Colors.yellow),
                    ],
                  ),
                ),
                totalReview == '0'
                    ? Text(
                        '0 reviews',
                        style: TextStyle(
                          color: AppColors.header,
                          fontFamily: 'Roboto-Regualar',
                          fontSize: 17,
                        ),
                      )
                    : Text(
                        '$totalReview reviews',
                        style: TextStyle(
                          color: AppColors.header,
                          fontFamily: 'Roboto-Regualar',
                          fontSize: 17,
                        ),
                      ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Descerption',
          style: TextStyle(
            color: AppColors.header,
            fontFamily: 'Roboto-Regualar',
            fontSize: 17,
          ),
        ),
        Text(
          bio,
          style: TextStyle(
            color: AppColors.header,
            fontFamily: 'Roboto-thin',
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
