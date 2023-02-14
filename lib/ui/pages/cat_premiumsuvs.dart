import 'package:flutter/material.dart';

import '../widgets/vehicle_cards.dart';

class CatPremiumSuvs extends StatefulWidget {
  const CatPremiumSuvs({super.key});

  @override
  State<CatPremiumSuvs> createState() => _CatPremiumSuvsState();
}

class _CatPremiumSuvsState extends State<CatPremiumSuvs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium SUVs'),
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
                image: 'assets/vehiclecategories/premiumsuvs.jpg',
                name: 'Toyota Land Cruiser Prado',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 15000'),
            selectVehiclesList(
                context: context,
                availability: true,
                id: "",
                image: 'assets/vehiclecategories/premiumsuvs.jpg',
                name: 'Toyota Land Cruiser Prado',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 15000'),
            selectVehiclesList(
                context: context,
                availability: true,
                id: "",
                image: 'assets/vehiclecategories/premiumsuvs.jpg',
                name: 'Toyota Land Cruiser Prado',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 15000'),
            selectVehiclesList(
                context: context,
                availability: true,
                id: "",
                image: 'assets/vehiclecategories/premiumsuvs.jpg',
                name: 'Toyota Land Cruiser Prado',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 15000'),
          ],
        ),
      )),
    );
  }
}
