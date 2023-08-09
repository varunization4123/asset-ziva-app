import 'package:flutter/material.dart';

class VendorsNearbyCard extends StatelessWidget {
  final Map<String, dynamic> snap;
  const VendorsNearbyCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Text('Vendor ${snap['name']}'),
        ),
      ),
    );
  }
}
