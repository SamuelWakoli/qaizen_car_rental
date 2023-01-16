import 'package:flutter/material.dart';

import '../widgets/drivers_card.dart';

class SelectDriver extends StatefulWidget {
  const SelectDriver({super.key});

  @override
  State<SelectDriver> createState() => _SelectDriverState();
}

class _SelectDriverState extends State<SelectDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Driver'),
        centerTitle: true,
      ),
      body: ListView(children: [
        driverCard(
            context: context,
            id: "",
            name: "\$driverName",
            image: "assets/driverholder.jpg",
            availabity: true,
            gender: "Female"),
        driverCard(
            context: context,
            id: "",
            name: "\$driverName",
            image: "assets/driverholder.jpg",
            availabity: true,
            gender: "Female"),
        driverCard(
            context: context,
            id: "",
            name: "\$driverName",
            image: "assets/driverholder.jpg",
            availabity: true,
            gender: "Female"),
        driverCard(
            context: context,
            id: "",
            name: "\$driverName",
            image: "assets/driverholder.jpg",
            availabity: true,
            gender: "Female"),
        driverCard(
            context: context,
            id: "",
            name: "\$driverName",
            image: "assets/driverholder.jpg",
            availabity: true,
            gender: "Female"),
        driverCard(
            context: context,
            id: "",
            name: "\$driverName",
            image: "assets/driverholder.jpg",
            availabity: true,
            gender: "Female"),
        driverCard(
            context: context,
            id: "",
            name: "\$driverName",
            image: "assets/driverholder.jpg",
            availabity: true,
            gender: "Female"),
        driverCard(
            context: context,
            id: "",
            name: "\$driverName",
            image: "assets/driverholder.jpg",
            availabity: true,
            gender: "Female"),
        driverCard(
            context: context,
            id: "",
            name: "\$driverName",
            image: "assets/driverholder.jpg",
            availabity: true,
            gender: "Female"),
        driverCard(
            context: context,
            id: "",
            name: "\$driverName",
            image: "assets/driverholder.jpg",
            availabity: true,
            gender: "Female"),
        driverCard(
            context: context,
            id: "",
            name: "\$driverName",
            image: "assets/driverholder.jpg",
            availabity: true,
            gender: "Female")
      ]),
    );
  }
}
