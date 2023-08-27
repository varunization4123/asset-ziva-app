import 'package:asset_ziva/screens/plot_screen.dart';
import 'package:asset_ziva/screens/property_screen.dart';
import 'package:asset_ziva/screens/real_estate_screen.dart';
import 'package:asset_ziva/screens/vendor_screen.dart';
import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/constants.dart';
import 'package:asset_ziva/widgets/home_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _searchResults = [];

  Future<void> searchCollections(String query) async {
    _searchResults.clear();

    // Perform searches in your collections here
    // You can use multiple queries for different collections
    QuerySnapshot collection1Snapshot = await _firestore
        .collection('services')
        .where('service', isEqualTo: query)
        .get();

    QuerySnapshot collection2Snapshot = await _firestore
        .collection('addOns')
        .where('addOn', isEqualTo: query)
        .get();

    _searchResults.addAll(collection1Snapshot.docs);
    _searchResults.addAll(collection2Snapshot.docs);

    setState(() {});
  }

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

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }

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
                      ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20, top: 14),
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       CustomSearchBar(
            //         hintText: 'Search',
            //         inputType: TextInputType.name,
            //         maxLines: 1,
            //         controller: searchController,
            //         controllerAction: () {
            //           searchController.clear();
            //         },
            //       ),
            //       // Expanded(
            //       //   child: ListView.builder(
            //       //     shrinkWrap: true,
            //       //     itemCount: _searchResults.length,
            //       //     itemBuilder: (context, index) {
            //       //       // Build your search result list items here
            //       //       return ListTile(
            //       //         title: Text(_searchResults[index]['field']),
            //       //       );
            //       //     },
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0.2,
                crossAxisSpacing: 0.2,
              ),
              shrinkWrap: true,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PropertyScreen()));
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: const HomeCard(
                    cardText: 'Property Management',
                    cardImg: 'assets/property-management.png',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlotScreen()));
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: const HomeCard(
                    cardText: 'Plot Management',
                    cardImg: 'assets/plot-management.png',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VendorScreen()));
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: const HomeCard(
                    cardText: 'Vendors',
                    cardImg: 'assets/vendors.png',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RealEstateScreen()));
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: const HomeCard(
                    cardText: 'Real Estate Services',
                    cardImg: 'assets/real-estate-services.png',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
