import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MakeAnOfferProductCardShop extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String productCondition;
  final String? imagePath;

  const MakeAnOfferProductCardShop({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productCondition,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    double height = 110;

    return Container(
      height: height,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          //Ảnh sản phẩm
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: imagePath != null
                ? (imagePath!.startsWith('http')
                      ? Image.network(
                          imagePath!,
                          width: height - 20,
                          height: height - 20,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: height - 20,
                              height: height - 20,
                              color: Colors.grey[200],
                              child: const Icon(
                                Iconsax.image,
                                color: Colors.grey,
                              ),
                            );
                          },
                        )
                      : Image.asset(
                          imagePath!,
                          width: height - 20,
                          height: height - 20,
                          fit: BoxFit.cover,
                        ))
                : Container(
                    width: height - 20,
                    height: height - 20,
                    color: Colors.grey[200],
                    child: const Icon(Iconsax.image, color: Colors.grey),
                  ),
          ),
          const SizedBox(width: 12),

          //Thông tin sản phẩm
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Tên sản phẩm
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto-Bold',
                    color: Colors.black,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),

                Text(
                  productCondition,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto-Regular',
                    color: Colors.black,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Original Price: $productPrice",
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto-Bold',
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
