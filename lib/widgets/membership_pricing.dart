import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/constants.dart';
import 'package:flutter/material.dart';

class MembershipPricing extends StatefulWidget {
  const MembershipPricing({super.key});

  @override
  State<MembershipPricing> createState() => _MembershipPricingState();
}

class _MembershipPricingState extends State<MembershipPricing> {
  bool isExpandedStd = false;
  bool isExpandedPrm = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 15),
          // height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor,
              width: 2.0,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: isExpandedStd == true
                        ? BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )
                        : BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Standard Plan',
                      style: TextStyle(fontSize: text, color: whiteColor),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (isExpandedStd == false) {
                            isExpandedStd = true;
                          } else {
                            isExpandedStd = false;
                          }
                        });
                      },
                      icon: isExpandedStd == false
                          ? Icon(
                              Icons.arrow_drop_down,
                              color: whiteColor,
                            )
                          : Icon(
                              Icons.arrow_drop_up,
                              color: whiteColor,
                            ),
                    ),
                  ],
                ),
              ),
              isExpandedStd == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Feature(feauture: 'Geotagging', icon: Icons.done),
                          Feature(
                              feauture: 'Property ID Board', icon: Icons.done),
                          Feature(
                              feauture: 'Boundary Marking', icon: Icons.done),
                          Feature(feauture: 'Personal Visit', icon: Icons.done),
                          Feature(
                              feauture: 'Property Photos', icon: Icons.done),
                          Feature(
                              feauture: 'Personal Online Dashboard',
                              icon: Icons.done),
                          Feature(feauture: 'Market Value', icon: Icons.done),
                          Feature(feauture: 'Site Cleaning', icon: Icons.done),
                          Feature(
                              feauture: 'EC (Encumbrance Certificate)',
                              icon: Icons.done),
                          Feature(
                              feauture: 'Buying/Selling Advisory',
                              icon: Icons.done),
                          Feature(
                              feauture: 'Asset Development Advisory',
                              icon: Icons.cancel),
                          Feature(
                              feauture: 'Field Assistant', icon: Icons.cancel),
                          Feature(
                              feauture: 'Live video on-demand',
                              icon: Icons.cancel),
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 30),
          // height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor,
              width: 2.0,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: isExpandedPrm == true
                        ? BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )
                        : BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Premium Plan',
                      style: TextStyle(fontSize: text, color: whiteColor),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (isExpandedPrm == false) {
                            isExpandedPrm = true;
                          } else {
                            isExpandedPrm = false;
                          }
                        });
                      },
                      icon: isExpandedPrm == false
                          ? Icon(
                              Icons.arrow_drop_down,
                              color: whiteColor,
                            )
                          : Icon(
                              Icons.arrow_drop_up,
                              color: whiteColor,
                            ),
                    ),
                  ],
                ),
              ),
              isExpandedPrm == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Feature(feauture: 'Geotagging', icon: Icons.done),
                          Feature(
                              feauture: 'Property ID Board', icon: Icons.done),
                          Feature(
                              feauture: 'Boundary Marking', icon: Icons.done),
                          Feature(feauture: 'Personal Visit', icon: Icons.done),
                          Feature(
                              feauture: 'Property Photos', icon: Icons.done),
                          Feature(
                              feauture: 'Personal Online Dashboard',
                              icon: Icons.done),
                          Feature(feauture: 'Market Value', icon: Icons.done),
                          Feature(feauture: 'Site Cleaning', icon: Icons.done),
                          Feature(
                              feauture: 'EC (Encumbrance Certificate)',
                              icon: Icons.done),
                          Feature(
                              feauture: 'Buying/Selling Advisory',
                              icon: Icons.done),
                          Feature(
                              feauture: 'Asset Development Advisory',
                              icon: Icons.done),
                          Feature(
                              feauture: 'Field Assistant', icon: Icons.done),
                          Feature(
                              feauture: 'Live video on-demand',
                              icon: Icons.done),
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ],
    );
  }
}

class Feature extends StatelessWidget {
  final String feauture;
  final IconData icon;
  const Feature({super.key, required this.feauture, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(feauture), Icon(icon)],
    );
  }
}
