import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final CurrentUser = FirebaseAuth.instance.currentUser;

String getUserName() {
  final user = FirebaseAuth.instance.currentUser;

  String? displayName = user?.displayName;
  String? email = user?.email;

  if (displayName != null) {
    return displayName.toString();
  }
  return email.toString();
}

final UserData =
    FirebaseFirestore.instance.collection('users').doc(getUserName());

final UserStorageFolder =
    FirebaseStorage.instance.ref("users_images/${getUserName()}");

String nameDateBooking = "${getUserName()} ${DateTime.now()}";
final Bookings =
    FirebaseFirestore.instance.collection('bookings').doc(nameDateBooking);

Future<String> getUserProfileImageURL() async {
  return UserStorageFolder.child('passport').getDownloadURL().toString();
}

List favoriteVehicles = [];

bool dbHasData = false;
bool isVerified = false;

String CurrentVehicleDocID = '';

bool notificationOn = true;
