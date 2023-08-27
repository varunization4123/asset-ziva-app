import 'package:asset_ziva/utils/colors.dart';
import 'package:flutter/material.dart';

class GallerySubScreen extends StatelessWidget {
  final Map<String, dynamic> snap;
  const GallerySubScreen({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Icon(Icons.image),
    );
  }
}
