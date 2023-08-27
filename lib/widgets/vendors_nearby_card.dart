import 'package:asset_ziva/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class VendorsNearbyCard extends StatelessWidget {
  final Map<String, dynamic> snap;
  const VendorsNearbyCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    int snapRating = snap['rating'];
    late double rating = snapRating.toDouble();

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Vendor ${snap['name']}'),
            RatingBar(
              itemSize: 20,
              initialRating: rating,
              allowHalfRating: true,
              ignoreGestures: true,
              ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  color: primaryColor,
                ),
                half: Icon(
                  Icons.star_half,
                  color: primaryColor,
                ),
                empty: Icon(
                  Icons.star,
                  color: borderColor,
                ),
              ),
              onRatingUpdate: (value) {},
            )
          ],
        ),
      ),
    );
  }
}
