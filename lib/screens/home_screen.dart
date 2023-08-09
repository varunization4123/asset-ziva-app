import 'package:asset_ziva/screens/plot_screen.dart';
import 'package:asset_ziva/screens/property_screen.dart';
import 'package:asset_ziva/screens/real_estate_screen.dart';
import 'package:asset_ziva/screens/vendor_screen.dart';
import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/constants.dart';
import 'package:asset_ziva/widgets/home_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 1,
        toolbarHeight: 72.0,
        title: const Row(
          children: [
            Icon(
              Icons.location_on,
              color: primaryColor,
              size: 24.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Location',
                  style: TextStyle(color: secondaryColor, fontSize: p),
                ),
                Text(
                  '560061, Bangalore',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: subP,
                  ),
                ),
              ],
            ),
          ],
        ),
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
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PropertyScreen()))
            },
            child: const HomeCard(
              cardText: 'Property Management',
              cardImg: 'assets/property-management.png',
            ),
          ),
          InkWell(
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PlotScreen()))
            },
            child: const HomeCard(
              cardText: 'Plot Management',
              cardImg: 'assets/plot-management.png',
            ),
          ),
          InkWell(
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const VendorScreen()))
            },
            child: const HomeCard(
              cardText: 'Vendors',
              cardImg: 'assets/vendors.png',
            ),
          ),
          InkWell(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RealEstateScreen()))
            },
            child: const HomeCard(
              cardText: 'Real Estate Services',
              cardImg: 'assets/real-estate-services.png',
            ),
          ),
        ],
      ),
    ));
  }
}
