import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../db/user.dart';
import '../../helper/vehicle_card_func.dart';
import '../../shared/hire_vehicle_data.dart';
import '../widgets/vehicle_card_available.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    String authUsername =
            FirebaseAuth.instance.currentUser!.displayName.toString(),
        photoURL = FirebaseAuth.instance.currentUser!.photoURL.toString();

    if (authUsername == 'null') authUsername = '';

    Future.delayed(Duration.zero, () async {
      var snapshot = await fireStoreUserData.get();

      if (snapshot.exists && snapshot.data()!.isNotEmpty) {
        setState(() {
          favoriteVehicles = snapshot['favorites'];
          userName = snapshot['name'];
          phoneNumber = snapshot['phone'];
        });
      } else {
        // if user has no favorites or referral code,
        // create new data to the account
        Map<String, dynamic> data = {
          'name': authUsername,
          'photoURL': photoURL,
          'phone': '',
          'favorites': favoriteVehicles,
          "referral code": generateRandomString(10),
        };
        await fireStoreUserData.set(data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('vehicles').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }

          return Scrollbar(
            thickness: 3,
            interactive: true,
            child: ListView(
                children: snapshot.data!.docs.toList().reversed.map((document) {
              return availableVehicleCard(
                  context: context,
                  id: document.id,
                  availability: document['availability'],
                  image: document['displayImageURL'],
                  name: document['name'],
                  price: document['priceDay'],
                  onClickHire: () {
                    serviceType = 'Self Drive';
                    currentVehicleDocID = document.id;
                    hire(context: context);
                  },
                  onClickDetails: () {
                    setState(() {
                      currentVehicleDocID = document.id;
                      details(context: context);
                    });
                  },
                  onClickBook: () {
                    currentVehicleDocID = document.id;
                    book(context: context);
                  });
            }).toList()),
          );
        });
  }
}
