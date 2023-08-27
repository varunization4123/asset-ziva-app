import 'package:asset_ziva/provider/auth_provider.dart';
import 'package:asset_ziva/resources/firestore_methods.dart';
import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/utils.dart';
import 'package:asset_ziva/widgets/custom_button.dart';
import 'package:asset_ziva/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';

class AddNewPropertyButton extends StatefulWidget {
  final String propertyId;
  final String client;
  const AddNewPropertyButton(
      {super.key, required this.propertyId, required this.client});

  @override
  State<AddNewPropertyButton> createState() => _AddNewPropertyButtonState();
}

class _AddNewPropertyButtonState extends State<AddNewPropertyButton> {
  final TextEditingController propertyName = TextEditingController();
  final TextEditingController propertyAddress = TextEditingController();
  final TextEditingController propertyArea = TextEditingController();
  final TextEditingController pinCode = TextEditingController();
  late String city = 'City';
  late String state = 'State';
  late String propertyType = 'Independent House';
  String status = "Active";
  static int timestamp = DateTime.now().millisecondsSinceEpoch;
  static DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  static String registeredOn = date.year.toString() +
      "/" +
      date.month.toString() +
      "/" +
      date.day.toString();

  List<String> cities = ['City'];
  List<String> states = ['State'];

  void createProperty({
    required String uid,
    required String propertyId,
    // Uint8List? propertyImage,
  }) async {
    try {
      String res = await FirestoreMethods().uploadProperty(
        context,
        // propertyImage!,
        propertyName.text,
        propertyType,
        widget.client,
        propertyAddress.text,
        city,
        state,
        propertyArea.text,
        pinCode.text,
        uid,
        registeredOn,
        status,
      );

      propertyAddress.clear();
      propertyName.clear();
      propertyArea.clear();
      pinCode.clear();

      print(res);

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
  void initState() {
    // TODO: implement initState
    fetchDataFromFirestore();
    super.initState();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('cities').get();
      List<String> citiesFirestore;
      List<String> statesFirestore;
      citiesFirestore = querySnapshot.docs.map((DocumentSnapshot document) {
        return document.get('city') as String;
      }).toList();
      Set<String> getStates = Set<String>();
      querySnapshot.docs.map((DocumentSnapshot document) {
        String fieldValue = document.get('state');
        getStates.add(fieldValue);
      }).toList();
      setState(() {
        cities.addAll(citiesFirestore);
        statesFirestore = getStates.toList();
        states.addAll(statesFirestore);
      }); // Trigger a rebuild to update the UI
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void dispose() {
    print('Dispose used');
    super.dispose();
    propertyName.dispose();
    propertyAddress.dispose();
    propertyArea.dispose();
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
                hintText: 'Property Name',
                inputType: TextInputType.name,
                maxLines: 1,
                controller: propertyName,
              ),
              CustomDropdownButton<String>(
                hintText: "PropertyType",
                options: const [
                  "Independent House",
                  "Apartment",
                  "Industrial Land",
                  "Mixed Use Land",
                  "Agriculture Land",
                  "Commercial Land",
                  "Residential",
                ],
                value: propertyType,
                onChanged: (String? value) {
                  setState(() {
                    propertyType = value!;
                    // state.didChange(newValue);
                  });
                },
                getLabel: (String? value) => value!,
              ),
              CustomTextField(
                hintText: 'Property/Plot Address',
                inputType: TextInputType.name,
                maxLines: 3,
                controller: propertyAddress,
              ),
              CustomDropdownButton<String>(
                hintText: "Choose City",
                options: cities,
                // options: const [
                //   "Bangalore",
                //   "Hyderabad",
                //   "Mumbai",
                //   "Kolkata",
                //   "Chennai",
                //   "Coimbatore",
                //   "Pune",
                //   "Delhi"
                // ],
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
                hintText: "Choose State",
                options: states,
                // options: const [
                //   "Karnataka",
                //   "Telangana",
                //   "Maharashtra",
                //   "West Bengal",
                //   "Tamil Nadu",
                //   "Kerala",
                //   "Uttar Pradesh",
                //   "Delhi"
                // ],
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
                controller: propertyArea,
              ),
            ],
          ),
          CustomButton(
            text: 'Add Property',
            onPressed: () {
              if (propertyName.text != "" &&
                  propertyAddress.text != "" &&
                  pinCode.text != "" &&
                  propertyArea.text != "") {
                createProperty(
                  uid: ap.userModel.phoneNumber,
                  propertyId: widget.propertyId,
                );
                setState(() {});
              } else if (city == "City" && state == "State") {
                showSnackBar(context, 'Please select the right option');
              } else {
                showSnackBar(context, 'Please enter all the fields');
              }
            },
          )
        ],
      ),
    );
  }
}
