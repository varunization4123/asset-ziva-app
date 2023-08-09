import 'package:asset_ziva/provider/auth_provider.dart';
import 'package:asset_ziva/screens/help_screen.dart';
import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/constants.dart';
import 'package:asset_ziva/widgets/add_new_property_button.dart';
import 'package:asset_ziva/widgets/prop_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropertyScreen extends StatelessWidget {
  const PropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: inputColor,
        elevation: 0,
        centerTitle: true,
        leading: TextButton(
          child: const Text(
            'Back',
            style: TextStyle(color: inputColor),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        leadingWidth: 60,
        title: const Text(
          "Property",
          style: TextStyle(color: inputColor, fontSize: h1),
        ),
        actions: [
          TextButton(
            child: const Text(
              "Help",
              style: TextStyle(color: inputColor),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HelpScreen()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Properties',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: gap),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('properties')
                          .where('uid', isEqualTo: ap.userModel.phoneNumber)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                            color: primaryColor,
                          );
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => PropertyCard(
                                  snap: snapshot.data!.docs[index].data(),
                                ));
                      },
                    ),
                    const SizedBox(height: gap),
                    SingleChildScrollView(
                      child: AddNewPropertyButton(
                        propertyId: ap.userModel.uid,
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: gap * 2),
                // const Text(
                //   'Other Services',
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // GridView.builder(
                //   physics: const ScrollPhysics(),
                //   scrollDirection: Axis.vertical,
                //   shrinkWrap: true,
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     mainAxisSpacing: 0.2,
                //     crossAxisSpacing: 0.2,
                //   ),
                //   itemCount: services.length,
                //   itemBuilder: (context, index) {
                //     return PropertyServicesCard(
                //         service: services[index]['service'],
                //         amount: services[index]['amount']);
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
