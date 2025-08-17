import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/screens/main_app/profile/report/report.dart';
import 'package:tradeupapp/screens/main_app/profile/save_product/controller/save_product_controller.dart';
import 'package:tradeupapp/screens/main_app/shop/controllers/shop_controller.dart';
import 'package:tradeupapp/screens/main_app/shop/personal.dart';

class PostCardBottomSheetShop extends StatelessWidget {
  const PostCardBottomSheetShop({
    super.key,
    required this.userId,
    required this.userName,
    required this.productId,
  });

  final String? userId, userName;
  final String productId;

  @override
  Widget build(BuildContext context) {
    final shopController = Get.find<ShopController>();
    final saveController = Get.find<SaveProductController>();

    return SafeArea(
      child: SizedBox(
        height: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 20),

            Obx(() {
              final isSaved = saveController.savedStatus[productId] ?? false;

              return _buildSheetItem(
                icon: isSaved ? Icons.bookmark : Icons.bookmark_outline,
                iconColor: isSaved ? const Color(0xFFFF6F61) : Colors.black,
                title: isSaved ? 'Removed from Save' : 'Save',
                onTap: () {
                  Navigator.pop(context);
                  if (userId != null) {
                    saveController.toggleSaveProduct(userId!, productId);
                  }
                },
              );
            }),
            _buildSheetItem(
              icon: Iconsax.user,
              title: 'View Account',
              onTap: () {
                Navigator.pop(context);
                Get.to(() => Personal(idUser: userId!));
                print('View Account');
              },
            ),
            _buildSheetItem(
              icon: Iconsax.message,
              title: 'Chat',
              onTap: () {
                Navigator.pop(context);
                shopController.handleCheckOrStartChat(
                  userId!,
                  context,
                  userName ?? 'User not Availabel',
                );
                print('Chat');
              },
            ),
            _buildSheetItem(
              icon: Icons.share,
              title: 'Share',
              onTap: () {
                Navigator.pop(context);
                print('Share');
              },
            ),
            _buildSheetItem(
              icon: Iconsax.warning_2,
              title: 'Report',
              isDestructive: true,
              onTap: () async {
                Navigator.pop(context);
                var tagName = await shopController.fetchTagNameByUserId(
                  userId!,
                );
                Get.to(() => Report(), arguments: tagName);
                print('Report');
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  static Widget _buildSheetItem({
    required IconData icon,
    required String title,
    IconData? trailingIcon,
    VoidCallback? onTap,
    bool isDestructive = false,
    Color? iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor ?? (isDestructive ? Colors.red : Colors.black),
                size: 22,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.w500,
                    color: isDestructive ? Colors.red : Colors.black,
                  ),
                ),
              ),
              if (trailingIcon != null)
                Icon(trailingIcon, size: 18, color: Colors.grey.shade600),
            ],
          ),
        ),
      ),
    );
  }
}
