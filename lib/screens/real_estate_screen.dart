import 'package:asset_ziva/screens/help_screen.dart';
import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/constants.dart';
import 'package:asset_ziva/widgets/property_services_card.dart';
import 'package:flutter/material.dart';

import '../utils/global_variables.dart';

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
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HelpScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: gap),
              // const Text(
              //   '  Other Services',
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const SizedBox(height: gap),
              GridView.builder(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.2,
                  crossAxisSpacing: 0.2,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return PropertyServicesCard(
                    service: services[index]['service'],
                    amount: services[index]['amount'],
                    image: services[index]['image'],
                    file: services[index]['file'],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
