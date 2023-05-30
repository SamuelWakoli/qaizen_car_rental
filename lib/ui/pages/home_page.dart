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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('vehicles').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }

          return ListView(
              children: snapshot.data!.docs.toList().reversed.map((document) {
            return availableVehicleCard(
                context: context,
                id: document.id,
                availability: document['availability'],
                image: document['displayImageURL'],
                name: document['name'],
                price: document['priceDay'],
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
          }).toList());
        });
  }
}
