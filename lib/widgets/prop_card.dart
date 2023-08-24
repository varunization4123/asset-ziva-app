import 'package:asset_ziva/utils/utils.dart';
import 'package:flutter/material.dart';

class PropertyCard extends StatefulWidget {
  final Map<String, dynamic> snap;

  const PropertyCard({super.key, required this.snap});

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  bool delete = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        setState(() {
          delete = true;
        });
      },
      onTap: () {
        setState(() {
          if (delete == true) {
            showSnackBar(context, 'You do not have permission to remove');
            delete = false;
          }
        });
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        color: delete == false ? Colors.white : Colors.red,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: delete == false
                ? Text('Property ${widget.snap['propertyName']}')
                : Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }
}
