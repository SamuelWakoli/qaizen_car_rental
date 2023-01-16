import 'package:flutter/material.dart';

import '../widgets/vehicle_cards.dart';

class CatPremiumSedans extends StatefulWidget {
  const CatPremiumSedans({super.key});

  @override
  State<CatPremiumSedans> createState() => _CatPremiumSedansState();
}

class _CatPremiumSedansState extends State<CatPremiumSedans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Sedans'),
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
                image: 'assets/vehiclecategories/premiumsedans.jpg',
                name: 'Toyota Crown',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 6000'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/premiumsedans.jpg',
                name: 'Toyota Crown',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 6000'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/premiumsedans.jpg',
                name: 'Toyota Crown',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 6000'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/premiumsedans.jpg',
                name: 'Toyota Crown',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 6000'),
          ],
        ),
      )),
    );
  }
}
