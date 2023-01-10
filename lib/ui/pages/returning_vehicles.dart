import 'package:flutter/material.dart';

class ReturningVehicles extends StatefulWidget {
  const ReturningVehicles({super.key});

  @override
  State<ReturningVehicles> createState() => _ReturningVehiclesState();
}

class _ReturningVehiclesState extends State<ReturningVehicles> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Returning Vehicles'),
          centerTitle: true,
        ),
      ),
    );
  }
}
