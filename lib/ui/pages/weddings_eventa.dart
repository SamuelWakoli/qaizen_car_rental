import 'package:flutter/material.dart';

class WeddingsEventsPage extends StatefulWidget {
  const WeddingsEventsPage({super.key});

  @override
  State<WeddingsEventsPage> createState() => _WeddingsEventsPageState();
}

class _WeddingsEventsPageState extends State<WeddingsEventsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weddings & Events'),
          centerTitle: true,
        ),
      ),
    );
  }
}
