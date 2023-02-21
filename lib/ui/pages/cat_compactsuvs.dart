import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/vehicle_cards.dart';

class CatCompactSuvs extends StatefulWidget {
  const CatCompactSuvs({super.key});

  @override
  State<CatCompactSuvs> createState() => _CatCompactSuvsState();
}

class _CatCompactSuvsState extends State<CatCompactSuvs> {
  String appBarTitle = 'Compact SUVs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('vehicles').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const ListTile(
                title: Text(
                    'No hatchbacks available at the moment. Please call us to reserve one.'),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((e) {
                return selectVehiclesList(
                    context: context,
                    availability: e['availability'],
                    appBarTitle: appBarTitle,
                    id: e.id,
                    category: e['category'],
                    image: e['displayImageURL'],
                    name: e['name'],
                    onClickDetails: null,
                    onClickSelect: null,
                    price: e['priceDay']);
              }).toList(),
            );
          }),
    );
  }
}
