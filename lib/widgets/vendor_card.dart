import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/constants.dart';
import 'package:flutter/material.dart';

class VendorCard extends StatelessWidget {
  final String cardText;
  final String cardImg;
  const VendorCard({super.key, required this.cardText, required this.cardImg});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1.5,
            color: backgroundColor,
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.35),
              spreadRadius: 8,
              blurRadius: 20,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            elevation: 6,
            child: Stack(
              children: [
                Image.network(
                  cardImg,
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: primaryColor.withOpacity(0.3),
                ),
                Positioned(
                  width: 160,
                  bottom: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cardText,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: text,
                        color: backgroundColor,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0, 0.0),
                            blurRadius: 20.0,
                            color: Color.fromARGB(166, 27, 27, 27),
                          ),
                          Shadow(
                            offset: Offset(0, 0.0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(185, 27, 27, 27),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
