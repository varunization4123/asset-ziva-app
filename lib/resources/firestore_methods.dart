// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:asset_ziva/model/plot_model.dart';
import 'package:asset_ziva/model/property_model.dart';
import 'package:flutter/material.dart';
import 'package:asset_ziva/utils/utils.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload Property
  Future<String> uploadProperty(
    BuildContext context,
    // Uint8List img,
    String propertyName,
    String propertyType,
    String client,
    String propertyAddress,
    String city,
    String state,
    String propertyArea,
    String pinCode,
    String uid,
    String registeredOn,
    String status,
    // Function onSuccess,
  ) async {
    String res = "Something went wrong";
    try {
      // String propertyUrl =
      //     await StorageMethods().uploadImageToStorage('propertyPic', img, true);

      String propertyId = const Uuid().v1();

      PropertyModel propertyModel = PropertyModel(
        propertyName: propertyName,
        propertyType: propertyType,
        client: client,
        propertyAddress: propertyAddress,
        propertyId: propertyId,
        city: city,
        state: state,
        propertyArea: propertyArea,
        pinCode: pinCode,
        // propertyUrl: propertyUrl,
        uid: uid,
        registeredOn: registeredOn,
        status: status,
      );

      _firestore
          .collection('properties')
          .doc(propertyId)
          .set(propertyModel.toMap());

      res = 'sucess';
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      notifyListeners();
    }

    return res;
  }

  //upload Plot
  Future<String> uploadPlot(
    BuildContext context,
    // Uint8List img,
    String plotName,
    String plotAddress,
    String plotType,
    String client,
    String city,
    String state,
    String plotArea,
    String pinCode,
    String uid,
    String registeredOn,
    String status,
    // Function onSuccess,
  ) async {
    String res = "Something went wrong";
    try {
      // String plotUrl =
      //     await StorageMethods().uploadImageToStorage('plotPic', img, true);

      String propertyId = const Uuid().v1();

      PlotModel plotModel = PlotModel(
        plotName: plotName,
        plotAddress: plotAddress,
        plotType: plotType,
        plotId: propertyId,
        client: client,
        city: city,
        state: state,
        plotArea: plotArea,
        pinCode: pinCode,
        // plotUrl: plotUrl,
        uid: uid,
        registeredOn: registeredOn,
        status: status,
      );

      _firestore
          .collection('plots')
          .doc(propertyId)
          .set(plotModel.toMap())
          .then((value) {
        _isLoading = false;
        notifyListeners();
      });

      res = 'sucess';
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      notifyListeners();
    }

    return res;
  }
}
