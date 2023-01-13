import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../widgets/vehicle_card.dart';

class CatWagons extends StatefulWidget {
  const CatWagons({super.key});

  @override
  State<CatWagons> createState() => _CatWagonsState();
}

class _CatWagonsState extends State<CatWagons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wagons'),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/wagons.jpg',
                name: 'Honda Fit Shuttle',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 4000'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/wagons.jpg',
                name: 'Honda Fit Shuttle',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 4000'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/wagons.jpg',
                name: 'Honda Fit Shuttle',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 4000'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/wagons.jpg',
                name: 'Honda Fit Shuttle',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 4000'),
          ],
        ),
      )),
    );
  }
}
