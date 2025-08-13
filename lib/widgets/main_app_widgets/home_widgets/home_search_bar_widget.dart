import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchBarHome extends StatelessWidget {
  const SearchBarHome({
    super.key,
    this.isReadOnly = false,
    this.onChanged,
    this.onTap,
    this.hintText = 'Looking for something...',
  });

  final bool isReadOnly;
  final VoidCallback? onTap;
  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(blurRadius: 5, offset: Offset(0, 2), color: Colors.black12),
        ],
      ),
      child: Row(
        children: [
          Icon(Iconsax.search_normal, size: 24, color: Colors.black54),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              readOnly: isReadOnly,
              onTap: onTap,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto-ThinItalic',
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
