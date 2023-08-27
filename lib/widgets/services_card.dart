import 'package:asset_ziva/sub_screens/property_documents_sub_screen.dart';
import 'package:asset_ziva/sub_screens/services_details_sub_screen.dart';
import 'package:asset_ziva/utils/colors.dart';
import 'package:asset_ziva/utils/constants.dart';
import 'package:asset_ziva/utils/utils.dart';
import 'package:flutter/material.dart';

class ServicesCard extends StatefulWidget {
  final Map<String, dynamic> snap;

  const ServicesCard({super.key, required this.snap});

  @override
  State<ServicesCard> createState() => _ServicesCardState();
}

class _ServicesCardState extends State<ServicesCard>
    with SingleTickerProviderStateMixin {
  bool delete = false;
  bool isExpanded = false;
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        setState(() {
          delete = true;
        });
      },
      onTap: () {
        setState(() {
          if (delete == true) {
            showSnackBar(context, 'You do not have permission to remove');
            delete = false;
          } else {
            if (isExpanded == false) {
              isExpanded = true;
            } else {
              isExpanded = false;
            }
          }
        });
      },
      child: isExpanded == false
          ? Card(
              margin: const EdgeInsets.only(bottom: 10),
              color: delete == false
                  ? Colors.white
                  : const Color.fromARGB(255, 255, 19, 2),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: delete == false
                      ? Text('Service ${widget.snap['service']}')
                      : Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                ),
              ),
            )
          : Card(
              margin: const EdgeInsets.only(bottom: 10),
              color: Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TabBar(
                      labelColor: whiteColor,
                      indicatorColor: primaryColor,
                      unselectedLabelColor: secondaryColor,
                      controller: _tabController,
                      indicator: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      tabs: [
                        Tab(
                          text: 'Details',
                        ),
                        Tab(
                          text: 'Documents',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: gap,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          ServicesDetialsSubScreen(snap: widget.snap),
                          PropertyDocumentsSubScreen(snap: widget.snap),
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
