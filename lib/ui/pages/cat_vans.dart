import 'package:flutter/material.dart';

import '../widgets/vehicle_cards.dart';

class CatVans extends StatefulWidget {
  const CatVans({super.key});

  @override
  State<CatVans> createState() => _CatVansState();
}

class _CatVansState extends State<CatVans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vans'),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            selectVehiclesList(
                context: context,
                availability: true,
                id: "",
                image: 'assets/vehiclecategories/vans.jpg',
                name: 'Toyota Voxy',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 6000'),
            selectVehiclesList(
                context: context,
                availability: true,
                id: "",
                image: 'assets/vehiclecategories/vans.jpg',
                name: 'Toyota Voxy',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 6000'),
            selectVehiclesList(
                context: context,
                availability: true,
                id: "",
                image: 'assets/vehiclecategories/vans.jpg',
                name: 'Toyota Voxy',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 6000'),
            selectVehiclesList(
                context: context,
                availability: true,
                id: "",
                image: 'assets/vehiclecategories/vans.jpg',
                name: 'Toyota Voxy',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 6000'),
          ],
        ),
      )),
    );
  }
}
