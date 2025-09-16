import 'package:flutter/material.dart';

class InforBuyerSalesHistory extends StatelessWidget {
  final String buyerName;
  final String totalPayment;
  const InforBuyerSalesHistory({
    super.key,
    required this.buyerName,
    required this.totalPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Colors.grey[700], size: 20),
              const SizedBox(width: 6),
              Text(
                "Buyer: $buyerName", // <-- sau này truyền buyerName vào
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.attach_money, color: Colors.green[700], size: 20),
              const SizedBox(width: 6),
              Text(
                "Total payment: $totalPayment", // <-- sau này truyền totalPrice vào
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
