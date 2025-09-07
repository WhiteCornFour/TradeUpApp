import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ViewOfferReceivedOfferCardUserProfile extends StatelessWidget {
  final String productName;
  final String productImage;
  final String offerUser;
  final double originPrice;
  final double offerPrice;
  final int status;
  final VoidCallback? onTap;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const ViewOfferReceivedOfferCardUserProfile({
    super.key,
    required this.productName,
    required this.productImage,
    required this.offerUser,
    required this.originPrice,
    required this.offerPrice,
    required this.status,
    this.onTap,
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

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 16),
        child: Stack(
          children: [
            Row(
              children: [
                //Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: productImage.startsWith('http')
                      ? Image.network(
                          productImage,
                          width: 120,
                          height: 130,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 120,
                              height: 130,
                              color: Colors.grey[200],
                              child: const Icon(
                                Iconsax.image,
                                color: Colors.grey,
                              ),
                            );
                          },
                        )
                      : Image.asset(
                          productImage,
                          width: 120,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                ),
      
                //Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //Product name
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Text(
                            productName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto-Bold',
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 6),
      
                        //Offered by
                        Row(
                          children: [
                            const Icon(
                              Iconsax.user,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                "Offered by: $offerUser",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Roboto-Regular',
                                  color: Colors.black54,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
      
                        //Action buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (status == 0) ...[
                              //Decline button
                              ElevatedButton.icon(
                                onPressed: onDecline,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.red,
                                  side: const BorderSide(
                                    color: Colors.red,
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                ),
                                icon: const Icon(
                                  Iconsax.close_circle,
                                  size: 18,
                                  color: Colors.red,
                                ),
                                label: const Text(
                                  "Decline",
                                  style: TextStyle(
                                    fontFamily: 'Roboto-Bold',
                                    fontSize: 14,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              //Accept button
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
                            ] else if (status == 1) ...[
                              SizedBox(
                                width: 220,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Iconsax.tick_circle,
                                        size: 18,
                                        color: Colors.green,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        "You have accepted this offer.",
                                        style: TextStyle(
                                          fontFamily: 'Roboto-Bold',
                                          fontSize: 12,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ] else if (status == 2) ...[
                              SizedBox(
                                width: 220,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Iconsax.close_circle,
                                        size: 18,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        "You have decline this offer.",
                                        style: TextStyle(
                                          fontFamily: 'Roboto-Bold',
                                          fontSize: 12,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
