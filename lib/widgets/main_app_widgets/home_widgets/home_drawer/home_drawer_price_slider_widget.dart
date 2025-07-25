import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';
import 'package:tradeupapp/widgets/system_widgets/system_header_section_widget.dart';

class DrawerPriceSliderHome extends StatefulWidget {
  const DrawerPriceSliderHome({super.key});

  @override
  State<DrawerPriceSliderHome> createState() => _DrawerPriceSliderHomeState();
}

class _DrawerPriceSliderHomeState extends State<DrawerPriceSliderHome> {
  RangeValues values = const RangeValues(10, 90);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Header Section: Prices
        HeaderSectionSystem(
          title: 'Prices',
          icon: Iconsax.money,
          showViewAll: false,
          paddingHorizontal: 0,
          paddingVertical: 0,
        ),
        SizedBox(height: 12),

        //Slider + Price Values
        Column(
          children: [
            //Text Min/Max
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${values.start.round()}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '\$${values.end.round()}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            //Custom Theme for Slider
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.header,
                inactiveTrackColor: Colors.grey.shade300,
                thumbColor: AppColors.header,
                overlayColor: AppColors.header.withOpacity(0.2),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                trackHeight: 4,
              ),
              child: RangeSlider(
                values: values,
                min: 0,
                max: 100,
                divisions: 20,
                labels: RangeLabels(
                  '\$${values.start.round()}',
                  '\$${values.end.round()}',
                ),
                onChanged: (newValues) {
                  setState(() {
                    values = newValues;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
