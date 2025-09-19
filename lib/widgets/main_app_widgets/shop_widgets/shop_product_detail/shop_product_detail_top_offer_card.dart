import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetailTopOfferCardShop extends StatelessWidget {
  final String? userName;
  final String? userAvatar;
  final double? offerPrice;
  final String? offerType; // "raise" | "counter"
  final int? status; // 1 = Top Offer, 3 = Paid

  const ProductDetailTopOfferCardShop({
    super.key,
    this.userName,
    this.userAvatar,
    this.offerPrice,
    this.offerType,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasOffer =
        userName != null && offerPrice != null && offerType != null;

    final Color offerTypeColor = (offerType?.toLowerCase() == "raise")
        ? Colors.green
        : Colors.red;
    final IconData offerTypeIcon = (offerType?.toLowerCase() == "raise")
        ? Iconsax.arrow_up
        : Iconsax.arrow_bottom;

    // if–else theo status
    if (!hasOffer) {
      return Container(
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Text(
            "There is no offer agreed for this product yet.\nBe the one to make this deal now!",
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto-Regular',
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else if (status == 1) {
      // Top Offer
      return _buildOfferCard(
        badgeText: "Top Offer",
        badgeColor: Colors.blue,
        textColor: Colors.black87,
        offerTypeColor: offerTypeColor,
        offerTypeIcon: offerTypeIcon,
      );
    } else if (status == 3) {
      // Paid
      return _buildOfferCard(
        badgeText: "Paid",
        badgeColor: Colors.green,
        textColor: Colors.green,
        offerTypeColor: offerTypeColor,
        offerTypeIcon: offerTypeIcon,
      );
    } else if (status == 2 || status == 0) {
      // Các status khác
      return _buildOfferCard(
        textColor: Colors.black87,
        offerTypeColor: offerTypeColor,
        offerTypeIcon: offerTypeIcon,
      );
    }

    // fallback
    return const SizedBox.shrink();
  }

  Widget _buildOfferCard({
    String? badgeText,
    Color? badgeColor,
    required Color textColor,
    required Color offerTypeColor,
    required IconData offerTypeIcon,
  }) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Nội dung chính
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: userAvatar != null
                    ? NetworkImage(userAvatar!)
                    : const AssetImage("assets/images/avatar-user.png")
                          as ImageProvider,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userName ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto-Bold',
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "\$${offerPrice?.toStringAsFixed(2) ?? "--"}",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto-Regular',
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Badge (nếu có)
          if (badgeText != null && badgeColor != null)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.15),
                  border: Border.all(color: badgeColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      badgeText == "Top Offer"
                          ? Iconsax.crown
                          : Iconsax.wallet_check,
                      size: 14,
                      color: badgeColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      badgeText,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto-Bold',
                        color: badgeColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Raise/Counter
          Positioned(
            bottom: 0,
            right: 0,
            child: Row(
              children: [
                Text(
                  offerType?.toLowerCase() == "raise" ? "Raise" : "Counter",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto-Bold',
                    color: offerTypeColor,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(offerTypeIcon, size: 18, color: offerTypeColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
