import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchBarAndFilterHome extends StatelessWidget {
  const SearchBarAndFilterHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Text Input Search Bar
        Expanded(
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  offset: Offset(0, 2),
                  color: Colors.black12,
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Iconsax.search_normal,
                  size: 24,
                  color: Colors.black54,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto-ThinItalic',
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Looking for something...',
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        //Filter Button
        Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black26),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                offset: Offset(0, 2),
                color: Colors.black12,
              ),
            ],
          ),
          child: const Icon(Icons.tune, size: 24, color: Colors.black54),
        ),
      ],
    );
  }
}
