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
    return displayName;
  }

  String? email = user.email;
  if (email == null) {
    return "";
  }

  String removeSpecialSymbols(String input) {
    int index = input.indexOf("@");
    return index >= 0 ? input.substring(0, index) : input;
  }

  //return removeSpecialSymbols(email);
  return email;
}

final UserData =
    FirebaseFirestore.instance.collection('users').doc(getUserName());

final UserStorageFolder =
    FirebaseStorage.instance.ref("users_images/${CurrentUser!.displayName}");

Future<String> getUserProfileImageURL() async {
  return UserStorageFolder.child('passport').getDownloadURL().toString();
}

final UserImages = UserData.collection('data').doc('images');

final UserPersonalData = UserData.collection('data').doc('personal data');

final UserReferees = UserData.collection('data').doc('referees');

//temporary var
bool dbHasData = false;
