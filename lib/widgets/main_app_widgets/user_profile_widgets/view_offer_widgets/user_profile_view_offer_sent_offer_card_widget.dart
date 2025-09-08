import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/offer_model.dart';
import 'package:tradeupapp/screens/main_app/shop/payment.dart';

class ViewOfferSentOfferCardUserProfile extends StatelessWidget {
  final String productImage;
  final String productName;
  final double offerPrice;
  final OfferModel offerModel;
  final int status;
  final VoidCallback? onTap;

  const ViewOfferSentOfferCardUserProfile({
    super.key,
    required this.productImage,
    required this.productName,
    required this.offerPrice,
    required this.status,
    this.onTap,
    required this.offerModel,
  });

  String getStatusText(int? status) {
    switch (status) {
      case 0:
        return "pending";
      case 1:
        return "accepted";
      case 2:
        return "rejected";
      default:
        return "unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            //Product Image
            SizedBox(
              height: 130,
              width: 120,
              child: productImage.startsWith('http')
                  ? Image.network(
                      productImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/noimageavailable.png",
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(productImage, fit: BoxFit.cover),
            ),

            //Content
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

                      //Trạng thái
                      if (status == 0) ...[
                        Row(
                          children: const [
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
                      ] else if (status == 1) ...[
                        Row(
                          children: const [
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
                            onPressed: () {
                              Get.to(Payment(offer: offerModel));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.header,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(
                              Iconsax.card,
                              color: Colors.white,
                              size: 18,
                            ),
                            label: const Text(
                              'Checkout',
                              style: TextStyle(
                                fontFamily: 'Roboto-Regular',
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ] else if (status == 2) ...[
                        Row(
                          children: const [
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
      ),
    );
  }
}
