import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/models/product_model.dart';

class ItemProductMessage extends StatelessWidget {
  final bool isRight;
  final Function(String) onPressed;
  final String timestamp;
  final ProductModel product;

  const ItemProductMessage({
    super.key,
    required this.isRight,
    required this.onPressed,
    required this.timestamp,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    String firstImage = product.imageList!.first;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: isRight
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: isRight
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: firstImage.isNotEmpty || firstImage != ''
                            ? Image.network(
                                firstImage,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/logo.png',
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15, top: 10),
                        height: 1,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey,
                        ),
                      ),

                      Text(
                        product.productName ?? 'Loading...',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'Roboto-Medium',
                          color: AppColors.header,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.productDescription ?? 'Loading...',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'Roboto-Regular',
                          color: AppColors.header,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Product price: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.header,
                              fontFamily: 'Rotobo-Regular',
                              fontSize: 14,
                            ),
                          ),
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                '${product.productPrice}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                  fontFamily: 'Rotobo-Medium',
                                  fontSize: 16,
                                ),
                              ),
                              Icon(Icons.attach_money, color: Colors.red),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Center(
                        child: SizedBox(
                          width: double.infinity, // full chiều rộng card
                          child: ElevatedButton(
                            onPressed: () {
                              onPressed(product.productId!);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: AppColors.background,
                            ),
                            child: const Text(
                              'View detail',
                              style: TextStyle(
                                color: AppColors.text,
                                fontFamily: 'Roboto-Medium',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  timestamp,
                  style: TextStyle(
                    color: AppColors.header,
                    fontFamily: 'Roboto-Regular',
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
