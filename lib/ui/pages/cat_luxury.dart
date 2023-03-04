import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../db/user.dart';
import '../../helper/vehicle_card_func.dart';
import '../../shared/hire_vehicle_data.dart';
import '../widgets/vehicle_cards.dart';
import '../widgets/widgets.dart';
import 'corporate_summary.dart';
import 'select_driver.dart';
import 'weddings_events_summary.dart';

class CatLuxury extends StatefulWidget {
  const CatLuxury({super.key});

  @override
  State<CatLuxury> createState() => _CatLuxuryState();
}

class _CatLuxuryState extends State<CatLuxury> {
  String appBarTitle = 'Luxury';
  double bottomHeight = 0;

  Widget listActions(ctx, list) {
    if (list.isEmpty) {
      return const SizedBox();
    } else {
      return Column(
        children: [
          Text(
            "Selection: ${selectedVehicleNames!.join(", ").toString()}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    selectedVehicleNames?.clear();
                    selectedVehicles?.clear();
                    bottomHeight = 0;
                  });
                },
                child: Row(
                  children: const [
                    Icon(Icons.clear),
                    SizedBox(width: 10),
                    Text('Clear')
                  ],
                ),
              ),
              const SizedBox(width: 30),
              OutlinedButton(
                onPressed: () async {
                  if (serviceType == "Chauffeured") {
                    driversNames?.clear();
                    nextPage(context: context, page: const SelectDriver());
                  } else if (serviceType == "Corporate") {
                    driversNames?.clear();
                    if (driverNeeded) {
                      nextPage(context: context, page: const SelectDriver());
                    } else {
                      totalCost = 0;
                      totalCost = await getCost().whenComplete(() => nextPage(
                          context: context, page: const CorporateSummary()));
                    }
                  } else if (serviceType == 'Weddings & Events') {
                    driversNames?.clear();
                    if (driverNeeded) {
                      nextPage(context: context, page: const SelectDriver());
                    } else {
                      totalCost = 0;
                      totalCost = await getCost().whenComplete(() => nextPage(
                          context: context,
                          page: const WeddingsEventsSummary()));
                    }
                  } else if (serviceType == 'Tours & Safaris') {
                    driversNames?.clear();
                    nextPage(context: context, page: const SelectDriver());
                  }
                },
                child: Row(
                  children: const [
                    Icon(Icons.done),
                    SizedBox(width: 10),
                    Text('Proceed')
                  ],
                ),
              )
            ],
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(bottomHeight),
          child: SingleChildScrollView(
            child: listActions(context, selectedVehicleNames),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('vehicles').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const ListTile(
                title: Text(
                    'No luxury vehicles available at the moment. Please call us to reserve one.'),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((e) {
                String vehicleName = e['name'];
                String vehicleId = e.id;
                bool availability = e['availability'];

                return selectVehiclesList(
                  context: context,
                  availability: e['availability'],
                  appBarTitle: appBarTitle,
                  id: vehicleId,
                  category: e['category'],
                  image: e['displayImageURL'],
                  name: vehicleName,
                  onClickDetails: () {
                    CurrentVehicleDocID = e.id;
                    return details(context: context);
                  },
                  onClickSelect: () {
                    if (availability) {
                      if (selectedVehicles!.contains(vehicleId)) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("$vehicleName is already selected")));
                      } else {
                        bottomHeight = 120;
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("$vehicleName selected")));
                        setState(() {
                          selectedVehicleNames?.add(vehicleName);
                          selectedVehicles?.add(e.id);
                        });
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "$vehicleName Is not available. Please call us to reserve.")));
                    }
                  },
                  price: e['priceDay'],
                );
              }).toList(),
            );
          }),
    );
  }
}
