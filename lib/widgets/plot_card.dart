import 'package:asset_ziva/utils/utils.dart';
import 'package:flutter/material.dart';

class PlotCard extends StatefulWidget {
  final Map<String, dynamic> snap;

  const PlotCard({super.key, required this.snap});

  @override
  State<PlotCard> createState() => _PlotCardState();
}

class _PlotCardState extends State<PlotCard> {
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
            showSnackBar(context, 'You do not have permission');
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
                ? Text('Plot ${widget.snap['plotName']}')
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
