import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../widgets/vehicle_card.dart';

class CatHatchbacks extends StatefulWidget {
  const CatHatchbacks({super.key});

  @override
  State<CatHatchbacks> createState() => _CatHatchbacksState();
}

class _CatHatchbacksState extends State<CatHatchbacks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hatchbacks'),
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
                image: 'assets/vehiclecategories/hatchbacks.jpg',
                name: 'Nissan Note',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 3500'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/hatchbacks.jpg',
                name: 'Nissan Note',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 3500'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/hatchbacks.jpg',
                name: 'Nissan Note',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 3500'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/hatchbacks.jpg',
                name: 'Nissan Note',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 3500'),
          ],
        ),
      )),
    );
  }
}
