import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PostCardBottomSheetShop extends StatelessWidget {
  const PostCardBottomSheetShop({super.key});

  @override
  Widget build(BuildContext context) {
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

            _buildSheetItem(
              icon: Icons.bookmark_outline,
              title: 'Save',
              onTap: () {
                Navigator.pop(context);
                print('Saved');
              },
            ),
            _buildSheetItem(
              icon: Iconsax.user,
              title: 'View Account',
              onTap: () {
                Navigator.pop(context);
                print('View Account');
              },
            ),
            _buildSheetItem(
              icon: Iconsax.message,
              title: 'Chat',
              onTap: () {
                Navigator.pop(context);
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
              onTap: () {
                Navigator.pop(context);
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
                color: isDestructive ? Colors.red : Colors.black,
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
