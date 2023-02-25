import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/pages/chauffeured_summary.dart';

import '../../shared/hire_vehicle_data.dart';
import '../widgets/drivers_card.dart';
import '../widgets/widgets.dart';

class SelectDriver extends StatefulWidget {
  const SelectDriver({super.key});

  @override
  State<SelectDriver> createState() => _SelectDriverState();
}

class _SelectDriverState extends State<SelectDriver> {
  double bottomHeight = 0;
  Widget listActions(ctx, list) {
    if (list.isEmpty) {
      return const SizedBox();
    } else {
      return Column(
        children: [
          Text(
            "Selection: ${driversNames!.join(", ").toString()}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    driversNames?.clear();
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
                    totalCost = 0;
                    totalCost = await getCost();
                    nextPage(context: context, page: const ChauffeuredSummary());
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
        title: const Text('Select Driver'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(bottomHeight),
          child: SingleChildScrollView(
            child: listActions(context, driversNames),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('drivers').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor));
            }

            return ListView(
              children: snapshot.data!.docs.map((e) {
                String driverName = e['name'];
                bool availability = e['availability'];
                return driverCard(
                    context: context,
                    onClickSelect: () {
                      if (availability) {
                        if (driversNames!.contains(driverName)) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("You have already selected $driverName")));
                        } else {
                          bottomHeight = 60;
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("You have selected $driverName")));
                          setState(() {
                            driversNames?.add(driverName);
                          });
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "$driverName Is not available. Please call us to get another driver.")));
                      }
                    },
                    id: e.id,
                    image: e['passport URL'],
                    name: e['name'],
                    gender: e['gender'],
                    availability: e['availability']);
              }).toList(),

              // [
              //   driverCard(
              //       context: context,
              //       id: "",
              //       name: "\$driverName",
              //       image: "assets/driverholder.jpg",
              //       availabity: true,
              //       gender: "Female"),
              //        ]
            );
          }),
    );
  }
}
