import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/firebase/database_service.dart';
import 'package:tradeupapp/models/offer_details_model.dart';
import 'package:tradeupapp/models/offer_model.dart';
import 'package:tradeupapp/models/product_model.dart';
import 'package:tradeupapp/models/user_model.dart';

class ProductCardPurchaseHistory extends StatelessWidget {
  final ProductModel productModel;
  final OfferModel offerModel;
  final OfferDetailsModel offerDetailsModel;

  const ProductCardPurchaseHistory({
    super.key,
    required this.productModel,
    required this.offerModel,
    required this.offerDetailsModel,
  });

  /// format thời gian
  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat("MMM dd, yyyy - HH:mm").format(dateTime);
  }

  /// map phương thức thanh toán
  String mapPaymentMethod(double? method) {
    switch (method) {
      case 0:
        return "Credit Card";
      case 1:
        return "Paypal";
      case 2:
        return "Cash";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.text),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Seller info ---
          FutureBuilder<UserModel?>(
            future: DatabaseService().fetchUserModelById(productModel.userId!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }
              if (!snapshot.hasData || snapshot.hasError) {
                return const Text(
                  "Failed to load seller info",
                  style: TextStyle(
                    color: AppColors.header,
                    fontFamily: "Roboto-Medium",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }

              final user = snapshot.data!;
              return Row(
                children: [
                  CircleAvatar(
                    backgroundImage: user.avtURL == null
                        ? const AssetImage("assets/images/logo.png")
                        : NetworkImage(user.avtURL!) as ImageProvider,
                    radius: 26,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullName ?? "Unknown seller",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.header,
                          ),
                        ),
                        Text(
                          user.address ?? "No address",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 18),

          /// --- Product block ---
          Text(
            "Product",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.header.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child:
                productModel.imageList != null &&
                    productModel.imageList!.isNotEmpty
                ? Image.network(
                    productModel.imageList!.first,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  )
                : Image.asset(
                    "assets/images/logo.png",
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
          ),

          const SizedBox(height: 12),

          Text(
            productModel.productName ?? "No product name",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.header,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Price: \$${offerModel.price ?? 0}",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Text(
                "Offer: \$${offerDetailsModel.totalPayment ?? 0}",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(thickness: 1, indent: 1),

          /// --- Payment info block ---
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                colors: [
                  AppColors.text,
                  const Color.fromARGB(255, 212, 240, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 18, color: Colors.grey),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "Paid at: ${formatTimestamp(offerDetailsModel.createdAt!)}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.header,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.credit_card, size: 18, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      "Method: ${mapPaymentMethod(offerDetailsModel.paymentMethod)}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.header,
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
