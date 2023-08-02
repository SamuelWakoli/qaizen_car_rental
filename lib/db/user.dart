import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

dynamic currentUser = FirebaseAuth.instance.currentUser;

String userID = FirebaseAuth.instance.currentUser!.email.toString();

final fireStoreUserData =
    FirebaseFirestore.instance.collection('users').doc(userID);

final firebaseStorageUserFolder =
    FirebaseStorage.instance.ref("users_images/$userID");

final userBookings = FirebaseFirestore.instance.collection('bookings');

Future<String> getUserProfileImageURL() async {
  return firebaseStorageUserFolder
      .child('passport')
      .getDownloadURL()
      .toString();
}

List favoriteVehicles = [];

bool dbHasData = false;
bool userDocExists = false;
bool isVerified = false;

String currentVehicleDocID = '';

bool notificationOn = true;

String generateRandomString(int lengthOfString) {
  final random = Random();
  const allChars =
      'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
  // below statement will generate a random string of length using the characters
  // and length provided to it
  final randomString = List.generate(
          lengthOfString, (index) => allChars[random.nextInt(allChars.length)])
      .join();
  return randomString; // return the generated string
}
