import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';
import 'package:tradeupapp/screens/main_app/profile/edit_profile/edit_profile.dart';

class AppbarCustomUserProfile extends StatelessWidget
    implements PreferredSizeWidget {
  final String? imageURL;
  final String? fullName;
  final String? address;
  final VoidCallback? onEditProfile;

  const AppbarCustomUserProfile({
    super.key,
    required this.onEditProfile,
    required this.imageURL,
    required this.fullName,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageURL != null && imageURL!.isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 240, 240, 240),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Avatar + Info
          Row(
            children: [
              // Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: hasImage
                        ? NetworkImage(imageURL!)
                        : const AssetImage('lib/assets/images/avatar-user.png')
                              as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // màu bóng mờ
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: Offset(0, 3), // dịch bóng xuống dưới
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              // User Info
              SizedBox(
                width:
                    MediaQuery.of(context).size.width *
                    0.4, // Giới hạn độ rộng để không đè nút Edit
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName ?? 'Unnamed',
                      style: const TextStyle(
                        color: AppColors.header,
                        fontSize: 16,
                        fontFamily: 'Roboto-Black',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.background,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            address ?? 'Unknown location',
                            style: const TextStyle(
                              color: AppColors.header,
                              fontSize: 13,
                              fontFamily: 'Roboto-Regular',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Edit Button
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfile()),
              );

              if (result == true && onEditProfile != null) {
                onEditProfile!(); // Gọi callback để reload dữ liệu
              }
            },

            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
              minimumSize: WidgetStateProperty.all<Size>(const Size(30, 30)),
              padding: WidgetStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              elevation: WidgetStateProperty.all(0),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.edit_square, color: AppColors.header, size: 16),
                SizedBox(width: 5),
                Text(
                  'Edit',
                  style: TextStyle(
                    color: AppColors.header,
                    fontFamily: 'Roboto-Regular',
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
