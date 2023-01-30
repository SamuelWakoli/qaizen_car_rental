import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'auth_gate.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final User = FirebaseAuth.instance.currentUser;
  String? profileImage = "https://source.unsplash.com/random";

  static Future<void> pop({bool? animated}) async {
    await SystemChannels.platform
        .invokeMethod<void>('SystemNavigator.pop', animated);
  }

  String userName = '', phoneNumber = '', emailAddress = '';
  String getUserName() {
    if (User?.displayName != null) {
      userName = User!.displayName.toString();
      if (userName == 'null') userName = '';
      return userName;
    } else {
      return userName;
    }
  }

  String getPhoneNumber() {
    if (User?.phoneNumber != null) {
      phoneNumber = User!.phoneNumber.toString();
      if (phoneNumber == 'null') phoneNumber = '';
      return phoneNumber;
    } else {
      return phoneNumber;
    }
  }

  String getEmailAddress() {
    if (User?.email != null) {
      emailAddress = User!.email.toString();
      if (emailAddress == 'null') emailAddress = '';
      return emailAddress;
    } else {
      return emailAddress;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        icon: const Icon(
                          FontAwesomeIcons.arrowRightFromBracket,
                          color: Colors.red,
                        ),
                        title: const Text('Sign Out'),
                        content: const Text(
                            "You are about to sign out of this app. Do you want to continue?"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return const AuthGate();
                              }), (r) {
                                return false;
                              });
                            },
                            child: const Text('Yes'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('No'),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(FontAwesomeIcons.arrowRightFromBracket))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: SizedBox(
                    height: 160,
                    width: 160,
                    child: Image.network(
                      profileImage!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                getUserName(),
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'Profile status: ',
                          style: TextStyle(fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Verified',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text.rich(
                        TextSpan(
                          text: 'Email address: ',
                          style: TextStyle(fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                              text: getEmailAddress(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
