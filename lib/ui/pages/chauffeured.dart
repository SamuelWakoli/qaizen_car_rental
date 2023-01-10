import 'package:flutter/material.dart';

class ChauffeuredPage extends StatefulWidget {
  const ChauffeuredPage({super.key});

  @override
  State<ChauffeuredPage> createState() => _ChauffeuredPageState();
}

class _ChauffeuredPageState extends State<ChauffeuredPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chauffeured'),
          centerTitle: true,
        ),
      ),
    );
  }
}
