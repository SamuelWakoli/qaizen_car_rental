import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/pages/home_page.dart';

class SelfDrive extends StatefulWidget {
  const SelfDrive({Key? key}) : super(key: key);

  @override
  State<SelfDrive> createState() => _SelfDriveState();
}

class _SelfDriveState extends State<SelfDrive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Self Drive Service"),
        centerTitle: true,
      ),
      body: const HomePage(),
    );
  }
}
