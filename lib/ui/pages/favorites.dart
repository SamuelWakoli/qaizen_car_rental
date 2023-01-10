import 'package:flutter/material.dart';

import '../../helper/vehicle_card_func.dart';
import '../widgets/vehicle_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  hire(context: context, vehicleID: null);
                });
              },
              onClickDetails: () {
                setState(() {
                  details(context: context, vehicleID: null);
                });
              },
            ),
            favCard(
              id: 'KDA',
              image: 'assets/cars/note.jpg',
              name: 'Nissan Note',
              price: '30,000',
              availabity: false,
              onClickHire: () {
                setState(() {
                  hire(context: context, vehicleID: null);
                });
              },
              onClickDetails: () {
                setState(() {
                  details(context: context, vehicleID: null);
                });
              },
            ),
            favCard(
              id: 'KDA',
              image: 'assets/cars/axio.jpeg',
              name: 'Toyota Axio',
              price: '0,000',
              availabity: true,
              onClickHire: () {
                setState(() {
                  hire(context: context, vehicleID: null);
                });
              },
              onClickDetails: () {
                setState(() {
                  details(context: context, vehicleID: null);
                });
              },
            ),
            favCard(
              id: 'KDA',
              image: 'assets/cars/crown.jpg',
              name: 'Toyota Crown',
              price: '6,000',
              availabity: false,
              onClickHire: () {
                setState(() {
                  hire(context: context, vehicleID: null);
                });
              },
              onClickDetails: () {
                setState(() {
                  details(context: context, vehicleID: null);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
