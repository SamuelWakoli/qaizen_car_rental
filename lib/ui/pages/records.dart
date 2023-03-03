import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/db/user.dart';

//todo: if service request is/was approved(bool), show records
//TODO use PDFs only for records
class RecordsPage extends StatefulWidget {
  const RecordsPage({Key? key}) : super(key: key);

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Records'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(getUserName())
              .collection('records')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
            }

            if (snapshot.data!.docs.toList().isEmpty) {
              return const Center(
                  child: Text(
                'No records found',
                style: TextStyle(fontSize: 18),
              ));
            }

            return ListView(
                children:
                    snapshot.data!.docs.reversed.toList().reversed.map((e) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                      subtitle: Text(
                        """
Date: ${e['starts']}
Duration: ${e['duration']} days
Service: ${e['type']}
Vehicle(s): ${e['vehicles list']}
Driver(s): ${e['drivers list']}
""",
                        style: const TextStyle(fontSize: 16),
                      )),
                ),
              );
            }).toList());
          }),
    );
  }
}
