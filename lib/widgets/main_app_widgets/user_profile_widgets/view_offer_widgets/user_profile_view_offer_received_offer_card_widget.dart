import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ViewOfferReceivedOfferCardUserProfile extends StatelessWidget {
  final String productName;
  final String productImage;
  final String offerUser;
  final double originPrice;
  final double offerPrice;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const ViewOfferReceivedOfferCardUserProfile({
    super.key,
    required this.productName,
    required this.productImage,
    required this.offerUser,
    required this.originPrice,
    required this.offerPrice,
    this.onAccept,
    this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    final double diff = offerPrice - originPrice;
    final bool isRaise = diff > 0;
    final bool isCounter = diff < 0;

    // Tag status
    Color tagColor;
    String tagLabel;
    IconData tagIcon;

    if (isRaise) {
      tagColor = Colors.green;
      tagLabel = "Raise";
      tagIcon = Iconsax.trend_up;
    } else if (isCounter) {
      tagColor = Colors.red;
      tagLabel = "Counter";
      tagIcon = Iconsax.trend_down;
    } else {
      tagColor = Colors.grey;
      tagLabel = "Same";
      tagIcon = Iconsax.minus_cirlce;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          Row(
            children: [
              //Product Image
              SizedBox(
                height: 130,
                width: 120,
                child: Image.asset(productImage, fit: BoxFit.contain),
              ),

              //Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Product name
                      Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto-Bold',
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Offered by
                      Row(
                        children: [
                          const Icon(
                            Iconsax.user,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Offered by: $offerUser",
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Roboto-Regular',
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Prices
                      Row(
                        children: [
                          Text(
                            "\$${originPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Roboto-Regular',
                              color: Colors.black45,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "\$${offerPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto-Bold',
                              color: isRaise
                                  ? Colors.green
                                  : isCounter
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: onDecline,
                            icon: const Icon(
                              Iconsax.close_circle,
                              size: 18,
                              color: Colors.red,
                            ),
                            label: const Text(
                              "Decline",
                              style: TextStyle(
                                fontFamily: 'Roboto-Regular',
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: onAccept,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                            ),
                            icon: const Icon(Iconsax.tick_circle, size: 18),
                            label: const Text(
                              "Accept",
                              style: TextStyle(
                                fontFamily: 'Roboto-Bold',
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Tag on top-right
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: tagColor.withOpacity(0.15),
                border: Border.all(color: tagColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(tagIcon, size: 14, color: tagColor),
                  const SizedBox(width: 4),
                  Text(
                    tagLabel,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto-Bold',
                      color: tagColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
