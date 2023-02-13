import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          favCard(
            id: 'KDA',
            image: 'assets/cars/teslamodelx.jpg',
            name: 'Tesla Model X',
            price: '30,000',
            availabity: true,
            onClickHire: () {
              setState(() {
                // CurrentVehicleDocID = document.id;
                // hire(context: context, vehicleID: null);
              });
            },
            onClickDetails: () {
              setState(() {
                // CurrentVehicleDocID = document.id;
                // details(context: context, vehicleID: null);
              });
            },
          ),
        ],
      ),
    );
  }
}
