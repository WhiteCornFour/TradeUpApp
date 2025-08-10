import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class InformationPersonal extends StatelessWidget {
  final String fullname;
  final String tagName;
  final String rating;
  final String bio;
  const InformationPersonal({
    super.key,
    required this.fullname,
    required this.tagName,
    required this.rating,
    required this.bio,
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
                      Text(
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

                Text(
                  'Rating',
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
