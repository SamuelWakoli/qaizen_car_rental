import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/pages/corporate_summary.dart';
import 'package:qaizen_car_rental/ui/pages/select_driver.dart';
import 'package:qaizen_car_rental/ui/pages/weddings_events_summary.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';

import '../../db/user.dart';
import '../../helper/vehicle_card_func.dart';
import '../../shared/hire_vehicle_data.dart';
import '../widgets/select_vehicle_list.dart';

class CatHatchbacks extends StatefulWidget {
  const CatHatchbacks({super.key});

  @override
  State<CatHatchbacks> createState() => _CatHatchbacksState();
}

class _CatHatchbacksState extends State<CatHatchbacks> {
  String appBarTitle = 'Hatchbacks';
  double bottomHeight = 0;

  Widget listActions(ctx, list) {
    if (list.isEmpty) {
      return const SizedBox();
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Selection: ${selectedVehicleNames!.join(", ").toString()}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
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
                child: const Row(
                  children: [
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
                child: const Row(
                  children: [
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
                    'No hatchbacks available at the moment. Please call us to reserve one.'),
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
                    currentVehicleDocID = e.id;
                    return details(context: context);
                  },
                  onClickSelect: () {
                    if (availability) {
                      if (selectedVehicles!.contains(vehicleId)) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("$vehicleName is already selected")));
                      } else {
                        bottomHeight = 120;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("$vehicleName selected"),
                          duration: const Duration(seconds: 2),
                        ));
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
