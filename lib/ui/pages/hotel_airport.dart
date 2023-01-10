import 'package:flutter/material.dart';

class HotelAirportPage extends StatefulWidget {
  const HotelAirportPage({super.key});

  @override
  State<HotelAirportPage> createState() => _HotelAirportPageState();
}

class _HotelAirportPageState extends State<HotelAirportPage> {
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
