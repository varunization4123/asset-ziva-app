import 'package:asset_ziva/provider/auth_provider.dart';
import 'package:asset_ziva/resources/firestore_methods.dart';
import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/utils.dart';
import 'package:asset_ziva/widgets/custom_button.dart';
import 'package:asset_ziva/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';

class AddNewPlotButton extends StatefulWidget {
  final String plotId;
  const AddNewPlotButton({super.key, required this.plotId});

  @override
  State<AddNewPlotButton> createState() => _AddNewPlotButtonState();
}

class _AddNewPlotButtonState extends State<AddNewPlotButton> {
  final TextEditingController plotName = TextEditingController();
  final TextEditingController plotAddress = TextEditingController();
  final TextEditingController plotArea = TextEditingController();
  final TextEditingController pinCode = TextEditingController();
  late String city = 'Bangalore';
  late String state = 'Karnataka';

  void createProperty({
    required String uid,
    required String propertyId,
    // Uint8List? propertyImage,
  }) async {
    try {
      String res = await FirestoreMethods().uploadPlot(
        context,
        // propertyImage!,
        plotName.text,
        plotAddress.text,
        city,
        state,
        plotArea.text,
        pinCode.text,
        uid,
      );

      plotAddress.clear();
      plotName.clear();
      plotArea.clear();
      pinCode.clear();

      if (res != 'sucess') {
        // ignore: use_build_context_synchronously
        showSnackBar(context, 'something went wrong');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }

  @override
  void dispose() {
    print('Dispose used');
    super.dispose();
    plotName.dispose();
    plotAddress.dispose();
    plotArea.dispose();
    pinCode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return DottedBorder(
      color: borderColor,
      strokeWidth: 2,
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      dashPattern: const [8, 3],
      child: ExpansionTile(
        title: const Text('Add New'),
        collapsedBackgroundColor: inputColor,
        // shape: OutlineInputBorder(
        //     borderSide: const BorderSide(color: borderColor, width: 2.0),
        //     borderRadius: BorderRadius.circular(10)),
        // Border.all(color: borderColor, width: 2.0, style: BorderStyle.solid),,
        textColor: placeholderColor,
        collapsedTextColor: placeholderColor,
        iconColor: placeholderColor,
        collapsedIconColor: placeholderColor,
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
        children: [
          Column(
            children: [
              CustomTextField(
                hintText: 'Plot Name',
                inputType: TextInputType.name,
                maxLines: 1,
                controller: plotName,
              ),
              CustomTextField(
                hintText: 'Plot Address',
                inputType: TextInputType.name,
                maxLines: 3,
                controller: plotAddress,
              ),
              CustomDropdownButton<String>(
                hintText: "City",
                options: const [
                  "Bangalore",
                  "Hyderabad",
                  "Mumbai",
                  "Kolkata",
                  "Chennai",
                  "Coimbatore",
                  "Pune",
                  "Delhi"
                ],
                value: city,
                onChanged: (String? value) {
                  setState(() {
                    city = value!;
                    // state.didChange(newValue);
                  });
                },
                getLabel: (String? value) => value!,
              ),
              CustomDropdownButton<String>(
                hintText: "State",
                options: const [
                  "Karnataka",
                  "Telangana",
                  "Maharashtra",
                  "West Bengal",
                  "Tamil Nadu",
                  "Kerala",
                  "Uttar Pradesh",
                  "Delhi"
                ],
                value: state,
                onChanged: (String? value) {
                  setState(() {
                    state = value!;
                    // state.didChange(newValue);
                  });
                },
                getLabel: (String? value) => value!,
              ),
              CustomTextField(
                hintText: 'Pincode',
                inputType: TextInputType.number,
                maxLines: 1,
                controller: pinCode,
              ),
              CustomTextField(
                hintText: 'Area (sqft)',
                inputType: TextInputType.number,
                maxLines: 1,
                controller: plotArea,
              ),
            ],
          ),
          CustomButton(
            text: 'Add Plot',
            onPressed: () {
              createProperty(
                uid: ap.userModel.phoneNumber,
                propertyId: widget.plotId,
              );
              setState(() {});
            },
          )
        ],
      ),
    );
  }
}
