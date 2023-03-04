import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/db/user.dart';

import '../../helper/vehicle_card_func.dart';
import '../widgets/vehicle_cards.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('vehicles').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }

            if (favoriteVehicles.isEmpty) {
              return const Center(
                  child: Text(
                'Like vehicles to add them to Favorites',
                style: TextStyle(fontSize: 18),
              ));
            }

            return ListView(
                children: snapshot.data!.docs.map((document) {
              return favCard(
                  context: context,
                  id: document.id,
                  image: document['displayImageURL'],
                  name: document['name'],
                  price: document['priceDay'],
                  availability: document['availability'],
                  onClickHire: () {
                    CurrentVehicleDocID = document.id;
                    hire(context: context);
                  },
                  onClickDetails: () {
                    CurrentVehicleDocID = document.id;
                    details(context: context);
                  });
            }).toList());
          }),
    );
  }
}
