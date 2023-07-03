// ignore_for_file: avoid_print

import 'package:asset_ziva/model/services_model.dart';
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
    String propertyAddress,
    String city,
    String state,
    String propertyArea,
    String pinCode,
    String uid,
    services,
    // Function onSuccess,
  ) async {
    String res = "Something went wrong";
    try {
      // String propertyUrl =
      //     await StorageMethods().uploadImageToStorage('propertyPic', img, true);

      String propertyId = const Uuid().v1();

      PropertyModel propertyModel = PropertyModel(
        propertyName: propertyName,
        propertyAddress: propertyAddress,
        propertyId: propertyId,
        city: city,
        state: state,
        propertyArea: propertyArea,
        pinCode: pinCode,
        // propertyUrl: propertyUrl,
        uid: uid,
        services: [],
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
    String city,
    String state,
    String plotArea,
    String pinCode,
    String uid,
    services,
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
        plotId: propertyId,
        city: city,
        state: state,
        plotArea: plotArea,
        pinCode: pinCode,
        // plotUrl: plotUrl,
        uid: uid,
        services: [],
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

  Future<String> addPropertyService(
    BuildContext context,
    // Uint8List img,
    String service,
    String amount,
    String city,
    String document,
    String propertyId,
    String uid,
    // Function onSuccess,
  ) async {
    String res = "Something went wrong";
    try {
      // String propertyUrl =
      //     await StorageMethods().uploadImageToStorage('propertyPic', img, true);

      String serviceId = const Uuid().v1();

      ServicesModel servicesModel = ServicesModel(
          service: service,
          amount: amount,
          city: city,
          document: document,
          propertyId: propertyId,
          uid: uid);

      _firestore
          .collection('properties')
          .doc(propertyId)
          .collection('services')
          .doc(serviceId)
          .set(servicesModel.toMap());

      res = 'sucess';
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      notifyListeners();
    }

    return res;
  }

  Future<String> addPlotService(
    BuildContext context,
    // Uint8List img,
    String service,
    String amount,
    String city,
    String document,
    String plotId,
    String uid,
    // Function onSuccess,
  ) async {
    String res = "Something went wrong";
    try {
      // String propertyUrl =
      //     await StorageMethods().uploadImageToStorage('propertyPic', img, true);

      String serviceId = const Uuid().v1();

      ServicesModel servicesModel = ServicesModel(
        service: service,
        amount: amount,
        city: city,
        document: document,
        propertyId: plotId,
        uid: uid,
      );

      _firestore
          .collection('properties')
          .doc(plotId)
          .collection('services')
          .doc(serviceId)
          .set(servicesModel.toMap());

      res = 'sucess';
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      notifyListeners();
    }

    return res;
  }
}
