import 'package:flutter/material.dart';

import '../widgets/vehicle_card.dart';

class CatSedans extends StatefulWidget {
  const CatSedans({super.key});

  @override
  State<CatSedans> createState() => _CatSedansState();
}

class _CatSedansState extends State<CatSedans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sedans'),
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
                image: 'assets/vehiclecategories/sedans.jpg',
                name: 'Toyota Allion',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 4000'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/sedans.jpg',
                name: 'Toyota Allion',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 4000'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/sedans.jpg',
                name: 'Toyota Allion',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 4000'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/sedans.jpg',
                name: 'Toyota Allion',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 4000'),
          ],
        ),
      )),
    );
  }
}
