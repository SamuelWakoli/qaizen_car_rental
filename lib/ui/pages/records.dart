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
      body: Card(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userID)
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
                  child:Card(
                    elevation: 0,
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (e['starts'] != null)
                            Text(
                              "Date: ${e['starts']}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          if (e['duration'] != null)
                            Text(
                              "Duration: ${e['duration']} days",
                              style: const TextStyle(fontSize: 16),
                            ),
                          Text(
                            "Service: ${e['type']}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          if (e['vehicles list'].isNotEmpty)
                            Text(
                              "Vehicle(s): ${e['vehicles list']}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          if (e['drivers list'].isNotEmpty)
                            Text(
                              "Driver(s): ${e['drivers list']}",
                              style: const TextStyle(fontSize: 16),
                            ),
                        ],
                      ),
                    ),
                  ),

                );
              }).toList());
            }),
      ),
    );
  }
}
