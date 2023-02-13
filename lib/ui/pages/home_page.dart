import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/widgets/vehicle_cards.dart';

import '../../db/user.dart';
import '../../helper/vehicle_card_func.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//replace these var by getting vehicle ID to get liked status.
  bool isLiked0 = false;

  bool isnotifyON1 = false;
  bool isnotifyON2 = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Available Vehicles'),
              Tab(text: 'Returning Vehicles'),
            ],
            indicatorColor: Theme.of(context).primaryColor,
          ),
        ),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('vehicles').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              }

              return TabBarView(
                children: [
                  ListView(
                      children: snapshot.data!.docs.map((document) {
                    return AvailableVehicleCard(
                        id: document.id,
                        availability: document['availability'],
                        image: document['displayImageURL'],
                        name: document['name'],
                        price: document['priceDay'],
                        isLiked: isLiked0,
                        onClickHire: () {
                          CurrentVehicleDocID = document.id;
                          hire(context: context);
                        },
                        onClickDetails: () {
                          setState(() {
                            CurrentVehicleDocID = document.id;
                            details(context: context);
                          });
                        });
                  }).toList()),
                  ListView(
                      children: snapshot.data!.docs.map((document) {
                    return ReturningVehicleCard(
                      id: document.id,
                      availability: document['availability'],
                      image: document['displayImageURL'],
                      name: document['name'],
                      price: document['priceDay'],
                      isLiked: isLiked0,
                      onClickDetails: () {
                        setState(() {
                          CurrentVehicleDocID = document.id;
                          details(context: context);
                        });
                      },
                      availabilityNotification: false,
                      onClickNotifyMe: null,
                    );
                  }).toList()),
                ],
              );
            }),
      ),
    );
  }
}
