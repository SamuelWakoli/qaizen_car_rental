import 'package:flutter/material.dart';

import '../widgets/vehicle_cards.dart';

class CatCompactSuvs extends StatefulWidget {
  const CatCompactSuvs({super.key});

  @override
  State<CatCompactSuvs> createState() => _CatCompactSuvsState();
}

class _CatCompactSuvsState extends State<CatCompactSuvs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compact SUVs'),
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
                image: 'assets/vehiclecategories/compactsuvs.jpg',
                name: 'Toyota Harrier',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 12000'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/compactsuvs.jpg',
                name: 'Toyota Harrier',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 12000'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/compactsuvs.jpg',
                name: 'Toyota Harrier',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 12000'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/compactsuvs.jpg',
                name: 'Toyota Harrier',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 12000'),
          ],
        ),
      )),
    );
  }
}
