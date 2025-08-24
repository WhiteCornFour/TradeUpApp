import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class ViewOfferSentOfferCardUserProfile extends StatelessWidget {
  final String productImage;
  final String productName;
  final double offerPrice;
  final String status;

  const ViewOfferSentOfferCardUserProfile({
    super.key,
    required this.productImage,
    required this.productName,
    required this.offerPrice,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          // Product Image
          SizedBox(
            height: 130,
            width: 120,
            child: Image.asset(productImage, fit: BoxFit.contain),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Roboto-Regular',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.tag,
                          size: 18,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Your offer: \$${offerPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Trạng thái
                    if (status == 'pending') ...[
                      Row(
                        children: [
                          Icon(Iconsax.clock, size: 18, color: Colors.orange),
                          SizedBox(width: 6),
                          Text(
                            'Seller has not responded yet',
                            style: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              fontSize: 14,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ] else if (status == 'accepted') ...[
                      Row(
                        children: [
                          Icon(
                            Iconsax.tick_circle,
                            size: 18,
                            color: Colors.green,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Your offer has been accepted',
                            style: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.header,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: Icon(
                            Iconsax.card,
                            color: Colors.white,
                            size: 18,
                          ),
                          label: Text(
                            'Checkout',
                            style: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ] else if (status == 'rejected') ...[
                      Row(
                        children: [
                          Icon(
                            Iconsax.close_circle,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Your offer has been rejected',
                            style: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              fontSize: 14,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
