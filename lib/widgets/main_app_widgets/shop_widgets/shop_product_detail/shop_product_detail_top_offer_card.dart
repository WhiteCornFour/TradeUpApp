import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetailTopOfferCardShop extends StatelessWidget {
  final String? userName;
  final String? userAvatar;
  final double? offerPrice;
  final String? offerType; // "raise" | "counter"
  final int? status;

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

    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: hasOffer ? Colors.white : Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        boxShadow: hasOffer
            ? [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Stack(
        children: [
          // Nội dung chính (avatar hoặc icon + info)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              hasOffer
                  ? CircleAvatar(
                      radius: 28,
                      backgroundImage: userAvatar != null
                          ? NetworkImage(userAvatar!)
                          : const AssetImage("assets/images/avatar-user.png")
                                as ImageProvider,
                    )
                  : const Icon(
                      Iconsax.dollar_circle,
                      size: 40,
                      color: Colors.black45,
                    ),
              const SizedBox(width: 12),
              Expanded(
                child: hasOffer
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userName!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto-Bold',
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "\$${offerPrice!.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto-Regular',
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: const Text(
                          "There is no offer agreed for this product yet.\nBe the one to make this deal now!",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto-Regular',
                            color: Colors.black54,
                          ),
                        ),
                      ),
              ),
            ],
          ),

          // Nhãn Top Offer (chỉ khi status == 1)
          if (hasOffer && status == 1)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.15),
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Icon(Iconsax.crown, size: 14, color: Colors.blue),
                    SizedBox(width: 4),
                    Text(
                      "Top Offer",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto-Bold',
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Raise/Counter (luôn có nếu hasOffer)
          if (hasOffer)
            Positioned(
              bottom: 0,
              right: 0,
              child: Row(
                children: [
                  Text(
                    offerType!.toLowerCase() == "raise" ? "Raise" : "Counter",
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
