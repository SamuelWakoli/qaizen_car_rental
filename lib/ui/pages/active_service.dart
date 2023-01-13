import 'package:flutter/material.dart';

class ActiveService extends StatefulWidget {
  const ActiveService({super.key});

  @override
  State<ActiveService> createState() => _ActiveServiceState();
}

class _ActiveServiceState extends State<ActiveService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Service'),
        centerTitle: true,
      ),
    );
  }
}
