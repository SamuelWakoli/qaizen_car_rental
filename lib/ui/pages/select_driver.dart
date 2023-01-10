import 'package:flutter/material.dart';

class SelectDriverPage extends StatefulWidget {
  const SelectDriverPage({super.key});

  @override
  State<SelectDriverPage> createState() => _SelectDriverPageState();
}

class _SelectDriverPageState extends State<SelectDriverPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hotel & Airport Transfer'),
          centerTitle: true,
        ),
      ),
    );
  }
}
