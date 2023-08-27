import 'package:asset_ziva/utils/colors.dart';
import 'package:flutter/material.dart';

class DetialsSubScreen extends StatelessWidget {
  final Map<String, dynamic> snap;
  const DetialsSubScreen({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Property Name: ${snap['propertyName']}',
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
            'Site Area: ${snap['state']}',
            style: TextStyle(
              color: secondaryColor,
            ),
          ),
          Text(
            'Property Address: ${snap['propertyAddress']}',
            style: TextStyle(
              color: secondaryColor,
            ),
          ),
          Text(
            'Pincode: ${snap['pinCode']}',
            style: TextStyle(
              color: secondaryColor,
            ),
          ),
          Text(
            'Property Type: ${snap['propertyType']}',
            style: TextStyle(
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
