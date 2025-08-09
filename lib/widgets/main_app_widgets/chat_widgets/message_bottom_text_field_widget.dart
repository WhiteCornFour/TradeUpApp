import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class BottomTextFieldMessage extends StatelessWidget {
  final TextEditingController messageController;
  final Function onPressedUploadImage;
  final VoidCallback onPressedSendMessage;
  final VoidCallback onPressedDeleteImageFile;
  final File? imageFile;
  final bool isLoadingButton;
  const BottomTextFieldMessage({
    super.key,
    required this.messageController,
    required this.onPressedSendMessage,
    required this.onPressedUploadImage,
    required this.onPressedDeleteImageFile,
    required this.imageFile,
    required this.isLoadingButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, -1),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Ô nhập tin nhắn
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: AppColors.header.withOpacity(0.3),
                    ),
                  ),
                  child: TextField(
                    //Controller message
                    controller: messageController,
                    style: TextStyle(
                      color: AppColors.header,
                      fontFamily: 'Roboto-Regular',
                    ),
                    decoration: const InputDecoration(
                      hintText: "Message...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                    minLines: 1,
                    maxLines: 5,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Nút thêm ảnh
              Column(
                children: [
                  // ignore: unnecessary_null_comparison
                  imageFile != null
                      ? Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                imageFile!,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: onPressedDeleteImageFile,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.black45,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(height: 10),
                  _iconCircleButton(
                    icon: Icons.add_photo_alternate_outlined,
                    onPressed: () {
                      onPressedUploadImage();
                    },
                  ),
                ],
              ),

              const SizedBox(width: 4),
              isLoadingButton
                  ? Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.background,
                      ),
                    )
                  : _iconCircleButton(
                      icon: Icons.send,
                      onPressed: onPressedSendMessage,
                      backgroundColor: AppColors.backgroundGrey,
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _iconCircleButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color backgroundColor = Colors.white,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: 26),
        color: AppColors.header,
        onPressed: onPressed,
      ),
    );
  }
}
