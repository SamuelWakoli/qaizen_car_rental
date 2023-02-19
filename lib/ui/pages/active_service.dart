import 'package:flutter/material.dart';

import '../../db/user.dart';

//todo: if a record was approved, get last entry

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
        title: const Text('My Service'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 810),
          child: StreamBuilder(
              stream: Bookings.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  );
                }

                return ListView(
                  children:
                  [
                    ListTile(
                      title: Text(snapshot.data!.get('vehicle name'), style: const TextStyle(fontSize: 22),),
                      subtitle: Text("""
Type: ${snapshot.data!.get('type')}
Commencing: ${snapshot.data!.get('starts')}
Duration: ${snapshot.data!.get('days')} day(s)
Total cost: ${snapshot.data!.get('total cost')}
${snapshot.data!.get('paid') ? 'Paid' : 'Not paid' }

Status: ${snapshot.data!.get('status')}
""", style: const TextStyle(fontSize: 20),),
                    ),
                    //TODO DOWNLOAD PDF HERE
                  ],
                );
              }),
        ),
      ),
    );
  }
}
