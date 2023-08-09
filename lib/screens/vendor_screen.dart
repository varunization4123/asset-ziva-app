import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/constants.dart';
import 'package:asset_ziva/widgets/vendor_card.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  String? _currentAddress;
  Position? _currentPosition;

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 1,
        toolbarHeight: 72.0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0.2,
          crossAxisSpacing: 0.2,
        ),
        shrinkWrap: true,
        children: [
          InkWell(
            onTap: () => {},
            child: const VendorCard(
              cardText: 'Fencing',
              cardImg: "assets/property-fencing.png",
            ),
          ),
          InkWell(
            onTap: () => {},
            child: const VendorCard(
              cardText: 'Painting',
              cardImg: "assets/property-painting.png",
            ),
          ),
          InkWell(
            onTap: () => {},
            child: const VendorCard(
              cardText: 'Water Connection',
              cardImg: "assets/property-plumbing.png",
            ),
          ),
          InkWell(
            onTap: () => {},
            child: const VendorCard(
              cardText: 'Construction',
              cardImg: "assets/property-construction.png",
            ),
          ),
          InkWell(
            onTap: () => {},
            child: const VendorCard(
              cardText: 'Civil Work',
              cardImg: "assets/property-construction.png",
            ),
          ),
          InkWell(
            onTap: () => {},
            child: const VendorCard(
              cardText: 'Lawyers',
              cardImg: "assets/property-lawyers.png",
            ),
          ),
        ],
      ),
    );
  }
}
