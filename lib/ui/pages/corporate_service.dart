import 'package:flutter/material.dart';

class CorporateServicePage extends StatefulWidget {
  const CorporateServicePage({super.key});

  @override
  State<CorporateServicePage> createState() => _CorporateServicePageState();
}

class _CorporateServicePageState extends State<CorporateServicePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Corporate Service'),
          centerTitle: true,
        ),
      ),
    );
  }
}
