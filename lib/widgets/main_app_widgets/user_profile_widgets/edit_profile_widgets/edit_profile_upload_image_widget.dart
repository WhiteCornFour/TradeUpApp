import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class UploadImageEditProfile extends StatelessWidget {
  final VoidCallback onPressedUploadImage;
  final String? imageUrl;
  final File? image;

  const UploadImageEditProfile({
    super.key,
    required this.onPressedUploadImage,
    required this.imageUrl,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final hasNetworkImage = imageUrl != null && imageUrl!.isNotEmpty;

    ImageProvider avatarProvider;
    if (image != null) {
      avatarProvider = FileImage(image!);
    } else if (hasNetworkImage) {
      avatarProvider = NetworkImage(imageUrl!);
    } else {
      avatarProvider =
          const AssetImage('assets/images/avatar-user.png');
    }

    return Center(
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: avatarProvider,
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onPressedUploadImage,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.header,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.text,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
