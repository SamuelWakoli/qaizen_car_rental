import 'package:flutter/material.dart';

class LeasePage extends StatefulWidget {
  const LeasePage({Key? key}) : super(key: key);

  @override
  State<LeasePage> createState() => _LeasePageState();
}

class _LeasePageState extends State<LeasePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lease with us'),
          centerTitle: true,
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 810),
          child: Center(
            child: Column(
              children: [
                Text('Lease with us'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
