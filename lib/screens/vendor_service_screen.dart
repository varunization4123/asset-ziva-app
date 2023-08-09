import 'dart:async';

import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/constants.dart';
import 'package:asset_ziva/widgets/custom_button.dart';
import 'package:asset_ziva/widgets/vendors_nearby_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VendorServiceScreen extends StatefulWidget {
  final String service;
  final String image;
  const VendorServiceScreen(
      {super.key, required this.service, required this.image});

  @override
  State<VendorServiceScreen> createState() => _VendorServiceScreenState();
}

class _VendorServiceScreenState extends State<VendorServiceScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  String? _currentAddress;
  Position? _currentPosition;
  String? _currentPincode;
  bool showMap = true;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.subAdministrativeArea}, ${place.postalCode}';
        _currentPincode = '${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    _getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor,
            elevation: 1,
            toolbarHeight: 72.0,
            centerTitle: false,
            leading: IconButton(
              onPressed: () {
                setState(() {
                  showMap = false;
                });
                Future.delayed(const Duration(milliseconds: 50), () {
                  Navigator.pop(context);
                });
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              color: secondaryColor,
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on,
                  color: primaryColor,
                  size: 30.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selected Location',
                      style: TextStyle(color: secondaryColor, fontSize: p),
                      textAlign: TextAlign.left,
                    ),
                    _currentAddress != Null
                        ? Text(
                            _currentAddress ?? "",
                            style: const TextStyle(
                              color: secondaryColor,
                              fontSize: subP,
                            ),
                            textAlign: TextAlign.left,
                          )
                        : const CircularProgressIndicator(
                            color: primaryColor,
                          )
                  ],
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      elevation: 6,
                      child: Stack(
                        children: [
                          Image.asset(
                            widget.image,
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            width: double.infinity,
                            height: 100,
                            color: primaryColor.withOpacity(0.3),
                          ),
                          Positioned(
                            width: 300,
                            left: 5,
                            bottom: 27,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.service,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  fontSize: h1,
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _currentPosition != null && showMap == true
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 2.0,
                            vertical: 12.0,
                          ),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(_currentPosition!.latitude,
                                    _currentPosition!.longitude),
                                zoom: 14.4746,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                            ),
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                  const SizedBox(height: gap),
                  const Text(
                    'Vendors near you',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: gap),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('vendors')
                        .where('service', isEqualTo: widget.service)
                        .where('pincode', isEqualTo: _currentPincode)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: primaryColor,
                        );
                      }
                      if (snapshot.data == null) {
                        print('No vendors nearby');
                        return const Text(
                          'No vendors nearby...',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        );
                      }
                      print('${snapshot.data!.docs.length} Vendors found');
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) => VendorsNearbyCard(
                                snap: snapshot.data!.docs[index].data(),
                              ));
                    },
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: CustomButton(
            text: 'Add Service',
            onPressed: () {},
          )),
    );
  }
}
