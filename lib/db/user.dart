import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final CurrentUser = FirebaseAuth.instance.currentUser;

String getUserName() {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return "";
  }

  String? displayName = user.displayName;
  if (displayName != null) {
    return displayName.toString();
  }

  String? email = user.email;
  if (email == null) {
    return "";
  }

  // String removeSpecialSymbols(String input) {
  //   int index = input.indexOf("@");
  //   return index >= 0 ? input.substring(0, index) : input;
  // }
  //
  // return removeSpecialSymbols(email).toString();
  return email.toString();
}

final UserData =
    FirebaseFirestore.instance.collection('users').doc(getUserName());

final UserStorageFolder =
    FirebaseStorage.instance.ref("users_images/${getUserName()}");

Future<String> getUserProfileImageURL() async {
  return UserStorageFolder.child('passport').getDownloadURL().toString();
}

//temporary var
bool dbHasData = false;

String CurrentVehicleDocID = '';
