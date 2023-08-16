import 'package:asset_ziva/screens/plot_screen.dart';
import 'package:asset_ziva/screens/property_screen.dart';
import 'package:asset_ziva/screens/real_estate_screen.dart';
import 'package:asset_ziva/screens/vendor_screen.dart';
import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/constants.dart';
import 'package:asset_ziva/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 1,
        toolbarHeight: 72.0,
        title: Row(
          children: [
            const Icon(
              Icons.location_on,
              color: primaryColor,
              size: 24.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Location',
                  style: TextStyle(color: secondaryColor, fontSize: p),
                ),
                _currentAddress != null
                    ? Text(
                        '$_currentAddress',
                        style: const TextStyle(
                          color: secondaryColor,
                          fontSize: subP,
                        ),
                      )
                    : const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: primaryColor,
                          strokeWidth: 2.5,
                        ),
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
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PropertyScreen()))
            },
            child: const HomeCard(
              cardText: 'Property Management',
              cardImg: 'assets/property-management.png',
            ),
          ),
          InkWell(
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PlotScreen()))
            },
            child: const HomeCard(
              cardText: 'Plot Management',
              cardImg: 'assets/plot-management.png',
            ),
          ),
          InkWell(
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const VendorScreen()))
            },
            child: const HomeCard(
              cardText: 'Vendors',
              cardImg: 'assets/vendors.png',
            ),
          ),
          InkWell(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RealEstateScreen()))
            },
            child: const HomeCard(
              cardText: 'Real Estate Services',
              cardImg: 'assets/real-estate-services.png',
            ),
          ),
        ],
      ),
    ));
  }
}
