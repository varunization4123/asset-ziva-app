import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/constants.dart';
import 'package:asset_ziva/widgets/vendor_card.dart';
import 'package:flutter/material.dart';

class VendorScreen extends StatelessWidget {
  const VendorScreen({super.key});

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
          "Vendors",
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
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0.2,
          crossAxisSpacing: 0.2,
        ),
        shrinkWrap: true,
        children: [
          InkWell(
            onTap: () => {},
            child: const VendorCard(
              cardText: 'Fencing',
              cardImg: 'https://assetziva.com/images/property-fencing.jpg',
            ),
          ),
          InkWell(
            onTap: () => {},
            child: const VendorCard(
              cardText: 'Painting',
              cardImg: 'https://assetziva.com/images/property-fencing.jpg',
            ),
          ),
          InkWell(
            onTap: () => {},
            child: const VendorCard(
              cardText: 'Water Connection',
              cardImg: 'https://assetziva.com/images/property-fencing.jpg',
            ),
          ),
          InkWell(
            onTap: () => {},
            child: const VendorCard(
              cardText: 'Construction',
              cardImg: 'https://assetziva.com/images/property-fencing.jpg',
            ),
          ),
          InkWell(
            onTap: () => {},
            child: const VendorCard(
              cardText: 'Civil Work',
              cardImg: 'https://assetziva.com/images/property-fencing.jpg',
            ),
          ),
          InkWell(
            onTap: () => {},
            child: const VendorCard(
              cardText: 'Lawyers',
              cardImg: 'https://assetziva.com/images/property-fencing.jpg',
            ),
          ),
        ],
      ),
    );
  }
}
