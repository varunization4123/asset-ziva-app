import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/constants.dart';
import 'package:asset_ziva/widgets/plot_card.dart';
import 'package:asset_ziva/widgets/prop_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:asset_ziva/provider/auth_provider.dart';
import 'package:asset_ziva/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            'Settings',
            style: TextStyle(color: inputColor),
          ),
          onPressed: () {},
        ),
        leadingWidth: 80,
        title: const Text(
          "Profile",
          style: TextStyle(color: inputColor, fontSize: h1),
        ),
        actions: [
          TextButton(
            child: const Text(
              "Logout",
              style: TextStyle(color: inputColor),
            ),
            onPressed: () {
              ap.userSignOut().then(
                    (value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                    ),
                  );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: primaryColor,
                      backgroundImage: NetworkImage(ap.userModel.profilePic),
                      radius: 50,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      ap.userModel.name,
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: h1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ap.userModel.phoneNumber,
                      style: const TextStyle(color: whiteColor, fontSize: text),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Your Properties'),
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
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => PropertyCard(
                                  snap: snapshot.data!.docs[index].data(),
                                ));
                      },
                    ),
                    // const SizedBox(height: gap),
                    // SingleChildScrollView(
                    //   child: AddNewPropertyButton(
                    //     propertyId: ap.userModel.uid,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Your Plots'),
                    const SizedBox(height: gap),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('plots')
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
                            itemBuilder: (context, index) => PlotCard(
                                  snap: snapshot.data!.docs[index].data(),
                                ));
                      },
                    ),
                    const SizedBox(height: gap),
                    // SingleChildScrollView(
                    //   child: AddNewPlotButton(
                    //     plotId: ap.userModel.uid,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Your Services'),
                    const SizedBox(height: gap),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('services')
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
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => PropertyCard(
                                  snap: snapshot.data!.docs[index].data(),
                                ));
                      },
                    ),
                    // const SizedBox(height: gap),
                    // SingleChildScrollView(
                    //   child: AddNewPropertyButton(
                    //     propertyId: ap.userModel.uid,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
