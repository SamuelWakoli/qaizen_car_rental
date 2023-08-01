import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/db/user.dart';

import '../../helper/vehicle_card_func.dart';
import '../widgets/vehicle_card_favorite.dart';

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

            return Scrollbar(
              thickness: 3,
              interactive: true,
              child: ListView(
                  children: snapshot.data!.docs.map((document) {
                return favCard(
                    context: context,
                    id: document.id,
                    image: document['displayImageURL'],
                    name: document['name'],
                    price: document['priceDay'],
                    availability: document['availability'],
                    onClickHire: () {
                      currentVehicleDocID = document.id;
                      hire(context: context);
                    },
                    onClickDetails: () {
                      currentVehicleDocID = document.id;
                      details(context: context);
                    });
              }).toList()),
            );
          }),
    );
  }
}
