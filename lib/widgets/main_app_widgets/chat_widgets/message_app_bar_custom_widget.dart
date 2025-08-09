import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class AppBarCustomMessage extends StatelessWidget
    implements PreferredSizeWidget {
  final String userName;
  final String? avatarUrl;
  final VoidCallback onPressedDelete;
  final VoidCallback onPressedBlock;

  const AppBarCustomMessage({
    super.key,
    required this.userName,
    this.avatarUrl,
    required this.onPressedBlock,
    required this.onPressedDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 1),
              // blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Left: Back + Avatar + Name
            Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.header,
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: avatarUrl != null
                      ? NetworkImage(avatarUrl!)
                      : const AssetImage("assets/images/avatar-user.png")
                            as ImageProvider,
                ),
                const SizedBox(width: 10),
                Text(
                  userName,
                  style: const TextStyle(
                    color: AppColors.header,
                    fontFamily: 'Roboto-Medium',
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            /// Right: Delete + Block
            Row(
              children: [
                IconButton(
                  onPressed: onPressedDelete,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.header,
                  ),
                ),
                IconButton(
                  onPressed: onPressedBlock,
                  icon: const Icon(
                    Icons.block_outlined,
                    color: AppColors.header,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
