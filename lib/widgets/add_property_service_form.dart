import 'dart:io';

import 'package:asset_ziva/model/property_services_model.dart';
import 'package:asset_ziva/provider/auth_provider.dart';
import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/constants.dart';
import 'package:asset_ziva/utils/utils.dart';
import 'package:asset_ziva/widgets/custom_button.dart';
import 'package:asset_ziva/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPropertyServiceForm extends StatefulWidget {
  final String service;
  final int amount;
  const AddPropertyServiceForm(
      {super.key, required this.service, required this.amount});

  @override
  State<AddPropertyServiceForm> createState() => _AddPropertyServiceFormState();
}

class _AddPropertyServiceFormState extends State<AddPropertyServiceForm> {
  File? file;
  String? property;
  late String propertyId;

  // for selecting file
  void selectFile() async {
    file = await pickFile(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;

    return Stack(
      children: <Widget>[
        Positioned(
          right: -40.0,
          top: -40.0,
          child: InkResponse(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close),
          ),
        ),
        Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 4.0,
                ),
                child: Text(
                  widget.service,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: placeholderText,
                  ),
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("properties")
                    .where('uid', isEqualTo: ap.userModel.phoneNumber)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  final userSnapshots = snapshot.data?.docs;
                  if (userSnapshots!.isEmpty) {
                    return const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      child: Text("Please Add a Property to continue"),
                    );
                  }
                  List<String> properties = [];
                  Map<String, String> propertiesIds = {};
                  for (var i = 0; i < userSnapshots.length; i++) {
                    properties.add(userSnapshots[i]["city"]);
                  }
                  for (var i = 0; i < userSnapshots.length; i++) {
                    propertiesIds.addAll({
                      userSnapshots[i]["propertyId"]: userSnapshots[i]["city"]
                    });
                  }
                  print(properties);
                  print(propertiesIds);

                  return CustomDropdownButton(
                    hintText: "choose property",
                    options: properties,
                    value: property,
                    onChanged: (value) {
                      setState(() {
                        property = value!;
                        propertyId = propertiesIds.keys.firstWhere(
                          (element) => propertiesIds[element] == property,
                        );
                      });
                    },
                    getLabel: (String? value) => value!,
                  );
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: borderColor,
                  ),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(borderColor),
                      ),
                      onPressed: () => selectFile(),
                      child: const Text(
                        'Choose File',
                        style: TextStyle(
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('file'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : CustomButton(
                          text: "Add Service",
                          onPressed: () {
                            if (property != null) {
                              storeFile();
                            } else {
                              showSnackBar(context, 'Please select the Plot');
                            }
                          }),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // store service file document to database
  void storeFile() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ServicesModel servicesModel = ServicesModel(
      service: widget.service,
      amount: widget.amount.toString(),
      city: 'Property $property',
      document: "",
      propertyId: propertyId,
      uid: '',
    );
    if (file != null) {
      ap.savePropertyServiceToFirebase(
        propertyId: propertyId,
        context: context,
        servicesModel: servicesModel,
        document: file!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pop(context),
                    ),
              );
        },
      );
    } else {
      showSnackBar(context, "Please select a file");
    }
  }
}
