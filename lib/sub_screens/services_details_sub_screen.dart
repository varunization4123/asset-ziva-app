import 'package:asset_ziva/utils/colors.dart';
import 'package:flutter/material.dart';

class ServicesDetialsSubScreen extends StatelessWidget {
  final Map<String, dynamic> snap;
  const ServicesDetialsSubScreen({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amount Paid: ${snap['amount']}',
            style: TextStyle(
              color: secondaryColor,
            ),
          ),
          Text(
            'City: ${snap['city']}',
            style: TextStyle(
              color: secondaryColor,
            ),
          ),
          Text(
            'Payment ID: ${snap['paymentId']}',
            style: TextStyle(
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
