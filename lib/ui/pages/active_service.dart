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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 810),
          child: ListView(
            children: const [
              ListTile(
                title: Text('Lexus LFA'),
                subtitle: Text("""
Duration: 08:00pm 21/02/2023 to 08:00pm 21/02/2023
Service: Self Drive
"""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
