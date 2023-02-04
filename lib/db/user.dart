import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final User = FirebaseAuth.instance.currentUser;

final UserData = FirebaseFirestore.instance
    .collection('users')
    .doc(User!.displayName.toString());

final UserStorageFolder =
    FirebaseStorage.instance.ref("users_images/${User!.displayName}");

final UserImages = UserData.collection('data').doc('images');

final UserPersonalData = UserData.collection('data').doc('personal data');

final UserReferees = UserData.collection('data').doc('referees');
