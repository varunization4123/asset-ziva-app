import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/constants.dart';
import 'package:asset_ziva/widgets/add_plot_service_form.dart';
import 'package:flutter/material.dart';

class PlotServicesCard extends StatefulWidget {
  final String service;
  final int amount;

  const PlotServicesCard({super.key, required this.service, required this.amount});

  @override
  State<PlotServicesCard> createState() => _PlotServicesCardState();
}

class _PlotServicesCardState extends State<PlotServicesCard> {
  var result;

  // void addPropertyService({
  //   required String uid,
  //   required String service,
  // }) async {
  //   try {
  //     String res = await FirestoreMethods().addPropertyService(
  //       context,
  //       service,
  //       amount,
  //       city,
  //       document,
  //       propertyId,
  //     );

  //     if (res != 'success') {
  //       showSnackBar(context, 'something went wrong');
  //     }
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: AddPlotServiceForm(
                  service: widget.service,
                  amount: widget.amount,
                ),
              );
            })
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.35),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1.0,
              color: borderColor,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 4,
                blurRadius: 12,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '₹ ${widget.amount}',
                style: const TextStyle(
                  fontSize: p + 4,
                  fontWeight: FontWeight.bold,
                  color: backgroundColor,
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
              const SizedBox(
                height: gap,
              ),
              Text(
                widget.service,
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontSize: p,
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
            ],
          ),
        ),
      ),
    );
  }
}
