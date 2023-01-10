import 'package:flutter/material.dart';

class ToursSafarisPage extends StatefulWidget {
  const ToursSafarisPage({super.key});

  @override
  State<ToursSafarisPage> createState() => _ToursSafarisPageState();
}

class _ToursSafarisPageState extends State<ToursSafarisPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tours & Safaris'),
          centerTitle: true,
        ),
      ),
    );
  }
}
