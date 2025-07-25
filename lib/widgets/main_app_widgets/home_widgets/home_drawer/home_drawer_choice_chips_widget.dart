import 'package:flutter/material.dart';

class DrawerChoiceChipsHome extends StatelessWidget {
  const DrawerChoiceChipsHome({
    super.key,
    required this.text,
    required this.selected,
    required this.color,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final Color color;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : color,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          fontFamily: 'Roboto-Medium',
        ),
      ),
      selected: selected,
      onSelected: onSelected,
      selectedColor: color,
      backgroundColor: Colors.transparent,
      checkmarkColor: Colors.white,
      shape: StadiumBorder(side: BorderSide(color: color)),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12),
    );
  }
}
