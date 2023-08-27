import 'package:flutter/material.dart';

class PaymentSubScreen extends StatelessWidget {
  final Map<String, dynamic> snap;
  const PaymentSubScreen({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Property Name: '),
          Text('City: '),
          Text('Site Area: '),
          Text('Property Address: '),
          Text('Pincode: '),
          Text('Property Type: '),
        ],
      ),
    );
  }
}
