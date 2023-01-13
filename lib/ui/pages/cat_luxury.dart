import 'package:flutter/material.dart';

import '../widgets/vehicle_card.dart';

class CatLuxury extends StatefulWidget {
  const CatLuxury({super.key});

  @override
  State<CatLuxury> createState() => _CatLuxuryState();
}

class _CatLuxuryState extends State<CatLuxury> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Luxury'),
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
                image: 'assets/vehiclecategories/luxury.jpg',
                name: 'Mercedes Benz S Class',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 75000'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/luxury.jpg',
                name: 'Mercedes Benz S Class',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 75000'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/luxury.jpg',
                name: 'Mercedes Benz S Class',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 75000'),
            selectVehiclesList(
                context: context,
                availabity: true,
                id: "",
                image: 'assets/vehiclecategories/luxury.jpg',
                name: 'Mercedes Benz S Class',
                onClickDetails: null,
                onClickSelect: null,
                price: 'Ksh. 75000'),
          ],
        ),
      )),
    );
  }
}
