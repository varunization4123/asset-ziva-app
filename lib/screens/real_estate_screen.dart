import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/constants.dart';
import 'package:flutter/material.dart';

class RealEstateScreen extends StatelessWidget {
  const RealEstateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: inputColor,
        elevation: 0,
        centerTitle: true,
        leading: TextButton(
          child: const Text(
            'Back',
            style: TextStyle(color: inputColor),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        leadingWidth: 60,
        title: const Text(
          "Real Estate",
          style: TextStyle(color: inputColor, fontSize: h1),
        ),
        actions: [
          TextButton(
            child: const Text(
              "Help",
              style: TextStyle(color: inputColor),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
