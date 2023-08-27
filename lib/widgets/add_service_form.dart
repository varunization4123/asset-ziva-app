import 'dart:io';

import 'package:asset_ziva/model/plot_services_model.dart';
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
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AddServiceForm extends StatefulWidget {
  final String service;
  final int amount;
  final List file;
  const AddServiceForm(
      {super.key,
      required this.service,
      required this.amount,
      required this.file});

  @override
  State<AddServiceForm> createState() => _AddServiceFormState();
}

class _AddServiceFormState extends State<AddServiceForm> {
  File? file;
  String? property;
  String? plot;
  late String propertyId;
  late String plotId;
  String? paymentId;
  String serviceType = "Property";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

    Future<bool> checkServiceExists() async {
      try {
        QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection('service requests')
            .where('uid', isEqualTo: ap.userModel.phoneNumber)
            .where('service', isEqualTo: widget.service)
            .get();

        return snapshot.docs.isNotEmpty;
      } catch (error) {
        print('Error checking data: $error');
        return false;
      }
    }

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
              CustomDropdownButton(
                hintText: "choose plot",
                options: const ["Property", "Plot"],
                value: serviceType,
                onChanged: (value) {
                  setState(() {
                    serviceType = value!;
                  });
                },
                getLabel: (String? value) => value!,
              ),
              serviceType == 'Property'
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("properties")
                          .where('uid', isEqualTo: ap.userModel.phoneNumber)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        final userSnapshots = snapshot.data?.docs;
                        if (userSnapshots!.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
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
                            userSnapshots[i]["propertyId"]: userSnapshots[i]
                                ["city"]
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
                    )
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("plots")
                          .where('uid', isEqualTo: ap.userModel.phoneNumber)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        final userSnapshots = snapshot.data?.docs;
                        if (userSnapshots!.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            child: Text("Please Add a Plot to continue"),
                          );
                        }
                        List<String> plots = [];
                        Map<String, String> plotsIds = {};
                        for (var i = 0; i < userSnapshots.length; i++) {
                          plots.add(userSnapshots[i]["city"]);
                        }
                        for (var i = 0; i < userSnapshots.length; i++) {
                          plotsIds.addAll({
                            userSnapshots[i]["plotId"]: userSnapshots[i]["city"]
                          });
                        }
                        print(plots);
                        print(plotsIds);

                        return CustomDropdownButton(
                          hintText: "choose plot",
                          options: plots,
                          value: plot,
                          onChanged: (value) {
                            setState(() {
                              plot = value!;
                              plotId = plotsIds.keys.firstWhere(
                                (element) => plotsIds[element] == plot,
                              );
                            });
                          },
                          getLabel: (String? value) => value!,
                        );
                      },
                    ),
              SizedBox(
                height: 300,
                width: 300,
                child: ListView.builder(
                  itemCount: widget.file.length,
                  itemBuilder: (context, index) {
                    String service = widget.file[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: gap,
                        ),
                        Text('Choose $service :'),
                        SizedBox(
                          height: gap,
                        ),
                        Addfile(
                          fileExists: file != null,
                          selectFile: selectFile,
                        ),
                      ],
                    );
                  },
                ),
              ),
              FutureBuilder(
                future: checkServiceExists(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    bool? alreadyExists = snapshot.data;
                    return Padding(
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
                                text: alreadyExists != true
                                    ? "Add Service"
                                    : "Service already Exists",
                                onPressed: () {
                                  if (alreadyExists != true) {
                                    if (property != null ||
                                        plot != null && file != null) {
                                      Razorpay razorpay = Razorpay();
                                      var options = {
                                        'key': 'rzp_live_ILgsfZCZoFIKMb',
                                        'amount': 500,
                                        'name': 'Asset Ziva',
                                        'description': 'Vendor Fees',
                                        'retry': {
                                          'enabled': true,
                                          'max_count': 1
                                        },
                                        'send_sms_hash': true,
                                        'prefill': {
                                          'contact': ap.userModel.name,
                                          'email': ap.userModel.email,
                                        },
                                        'external': {
                                          'wallets': ['paytm']
                                        }
                                      };
                                      razorpay.on(
                                        Razorpay.EVENT_PAYMENT_ERROR,
                                        handlePaymentErrorResponse,
                                      );
                                      razorpay.on(
                                          Razorpay.EVENT_PAYMENT_SUCCESS,
                                          handlePaymentSuccessResponse);
                                      razorpay.on(
                                          Razorpay.EVENT_EXTERNAL_WALLET,
                                          handleExternalWalletSelected);
                                      razorpay.open(options);
                                    } else if (property == null ||
                                        plot == null) {
                                      showSnackBar(
                                          context, 'Please select the Plot');
                                    } else {
                                      showSnackBar(
                                          context, 'Please select a file');
                                    }
                                  }
                                }),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  // Payment Failure
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  // Payment Success
  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */

    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
    setState(() {
      paymentId = response.paymentId;
    });
    storeFile();
  }

  // External Wallet
  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            primaryColor,
          ),
        ),
        child: title == 'Payment Successful'
            ? const Text("Continue")
            : const Text("Try Again"),
        onPressed: () {
          if (title == 'Payment Successful') {
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
    // set up the AlertDialog
    Center alert = Center(
      child: AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        // content: Text(message),
        actions: [
          continueButton,
        ],
      ),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // store service file document to database
  void storeFile() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    if (property != null) {
      PropertyServicesModel propertyServicesModel = PropertyServicesModel(
        service: widget.service,
        client: ap.userModel.name,
        amount: widget.amount.toString(),
        city: 'Property $property',
        document: "",
        propertyId: propertyId,
        uid: '',
        paymentId: paymentId!,
      );
      print('Property storeFile triggered');
      ap.savePropertyServiceToFirebase(
        propertyId: propertyId,
        context: context,
        propertyServicesModel: propertyServicesModel,
        document: file!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pop(context),
                    ),
              );
        },
      );
    } else if (plot != null) {
      PlotServicesModel plotServicesModel = PlotServicesModel(
        service: widget.service,
        client: ap.userModel.name,
        amount: widget.amount.toString(),
        city: 'Plot $plot',
        document: "",
        plotId: plotId,
        uid: '',
        paymentId: paymentId!,
      );
      print('Plot storeFile triggered');
      ap.savePlotServiceToFirebase(
        plotId: plotId,
        context: context,
        plotServicesModel: plotServicesModel,
        document: file!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pop(context),
                    ),
              );
        },
      );
    }
  }
}

class Addfile extends StatelessWidget {
  final void Function()? selectFile;
  final bool fileExists;
  const Addfile(
      {super.key, required this.selectFile, required this.fileExists});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(borderColor),
            ),
            onPressed: selectFile,
            child: const Text(
              'Choose File',
              style: TextStyle(
                color: secondaryColor,
              ),
            ),
          ),
          fileExists == true
              ? Icon(
                  Icons.check_circle,
                  color: primaryColor,
                )
              : Text('...'),
          TextButton(
            onPressed: () {
              showSnackBar(
                  context, 'Request for this document has been raised');
            },
            child: Text(
              'request',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
