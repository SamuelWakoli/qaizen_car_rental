import 'package:flutter/material.dart';

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
        title: const Text('Drivers'),
        centerTitle: true,
      ),
      body: ListView(children: []),
    );
  }
}
