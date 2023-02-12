import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/widgets/vehicle_cards.dart';

import '../../helper/vehicle_card_func.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//replace these var by getting vehicle ID to get liked status.
  bool isLiked0 = false;
  bool isLiked1 = false;
  bool isLiked2 = false;
  bool isLiked3 = false;
  bool isLiked4 = false;
  bool isLiked5 = false;
  bool isLiked6 = false;
  bool isLiked7 = false;
  bool isLiked8 = false;
  bool isLiked9 = false;
  bool isLiked10 = false;
  bool isLiked11 = false;
  bool isLiked12 = false;
  bool isLiked13 = false;
  bool isLiked14 = false;
  bool isLiked15 = false;

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
                          hire(context: context, vehicleID: document.id);
                        },
                        onClickDetails: () {
                          setState(() {
                            details(context: context, vehicleID: null);
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
                          details(context: context, vehicleID: null);
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
