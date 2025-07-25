import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  final String userName;
  final String userAvatar;

  //If their is a avatar, we will use image, if not, we use icon
  bool get hasValidAvatar => userAvatar.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.grey[300],
                backgroundImage: hasValidAvatar
                    ? NetworkImage(userAvatar)
                    : null,
                child: !hasValidAvatar
                    ? const Icon(Icons.person, color: Colors.black)
                    : null,
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back, ',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontFamily: 'Roboto-Regular',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto-Bold',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black54, width: 1.5),
            ),
            child: IconButton(
              icon: const Icon(Iconsax.bookmark),
              color: Colors.black,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
