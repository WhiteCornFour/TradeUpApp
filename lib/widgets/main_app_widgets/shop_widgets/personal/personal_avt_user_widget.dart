import 'package:flutter/material.dart';

class AvtUserPersonal extends StatelessWidget {
  const AvtUserPersonal({super.key, required this.imageURL});
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -6,
      child: Container(
        height: 110,
        width: 110,
        margin: EdgeInsets.only(left: 16),
        child: ClipOval(
          child: imageURL.isNotEmpty
              ? Image.network(
                  imageURL,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Image.asset(
                      'assets/images/avatar-user.png',
                      fit: BoxFit.cover,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/avatar-user.png',
                      fit: BoxFit.cover,
                    );
                  },
                )
              : Image.asset('assets/images/avatar-user.png', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
