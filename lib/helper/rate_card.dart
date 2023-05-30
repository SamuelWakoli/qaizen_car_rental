import 'package:cloud_firestore/cloud_firestore.dart';

String rateCardUrl = '';

getRateCardUrl() {
  FirebaseFirestore.instance
      .collection('public data')
      .doc('rate card')
      .get()
      .then((DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      rateCardUrl = snapshot.get('rate card url');
    } else {
// Document does not exist
    }
  }).catchError((error) {
// Error occurred while retrieving the document
  });
}
