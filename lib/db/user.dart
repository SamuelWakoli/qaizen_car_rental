import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

dynamic currentUser = FirebaseAuth.instance.currentUser;

String getUserName() {
  final user = FirebaseAuth.instance.currentUser;

  String? displayName = user?.displayName;
  String? email = user?.email;

  if (displayName != null) {
    return displayName.toString();
  }
  return email.toString();
}

final fireStoreUserData =
    FirebaseFirestore.instance.collection('users').doc(getUserName());

final firebaseStorageUserFolder =
    FirebaseStorage.instance.ref("users_images/${getUserName()}");

final userBookings = FirebaseFirestore.instance.collection('bookings');

Future<String> getUserProfileImageURL() async {
  return firebaseStorageUserFolder
      .child('passport')
      .getDownloadURL()
      .toString();
}

List favoriteVehicles = [];

bool dbHasData = false;
bool isVerified = false;
bool canUserHireOrLike = false;

String currentVehicleDocID = '';

bool notificationOn = true;
