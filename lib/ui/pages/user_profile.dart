import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaizen_car_rental/ui/pages/account_verification.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';

import '../../db/user.dart';
import 'auth_gate.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final currentUser = FirebaseAuth.instance.currentUser;

  // static Future<void> pop({bool? animated}) async {
  //   await SystemChannels.platform
  //       .invokeMethod<void>('SystemNavigator.pop', animated);
  // }

  String userName = '', phoneNumber = '', emailAddress = '';
  String getUserName() {
    if (currentUser?.displayName != null) {
      userName = currentUser!.displayName.toString();
      if (userName == 'null') userName = '';
      return userName;
    } else {
      return userName;
    }
  }

  String getPhoneNumber() {
    if (currentUser?.phoneNumber != null) {
      phoneNumber = currentUser!.phoneNumber.toString();
      if (phoneNumber == 'null') phoneNumber = '';
      return phoneNumber;
    } else {
      return phoneNumber;
    }
  }

  String getEmailAddress() {
    if (currentUser?.email != null) {
      emailAddress = currentUser!.email.toString();
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
        body: StreamBuilder(
          stream: UserImages.snapshots(),
          builder: (context, snapshot) {
            String profileImageURL =
                snapshot.data!.get('passport URL').toString();
            // if profileImageURL empty, use holder image
            if (profileImageURL == "") {
              profileImageURL =
                  "https://firebasestorage.googleapis.com/v0/b/qaizen-car-rental-2023.appspot.com/o/app_assets%2FprofileHolder.png?alt=media&token=4eaddbdf-bce9-4421-b2bb-6efd7d570dc9";
            }
            if (!snapshot.hasData) {
              return CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              );
            } else {
              return SingleChildScrollView(
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
                              child: StreamBuilder(
                                  stream: UserImages.snapshots(),
                                  builder: (context, snapshot) {
                                    String profileImageURL = snapshot.data!
                                        .get('passport URL')
                                        .toString();
                                    // if profileImageURL empty, use holder image
                                    if (profileImageURL == "") {
                                      profileImageURL =
                                          "https://firebasestorage.googleapis.com/v0/b/qaizen-car-rental-2023.appspot.com/o/app_assets%2FprofileHolder.png?alt=media&token=4eaddbdf-bce9-4421-b2bb-6efd7d570dc9";
                                    }

                                    return CachedNetworkImage(
                                      imageUrl: profileImageURL,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              CircularProgressIndicator(
                                        value: downloadProgress.progress,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      errorWidget:
                                          (context, url, downloadProgress) =>
                                              const Icon(Icons.error_outline),
                                    );

                                    return Image.network(
                                      profileImageURL,
                                      fit: BoxFit.fitHeight,
                                      filterQuality: FilterQuality.high,
                                      scale: 1,
                                    );
                                  })),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        getUserName(),
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StreamBuilder(
                                  stream: UserPersonalData.snapshots(),
                                  builder: (context, snapshot) {
                                    bool verified =
                                        snapshot.data!.get('verified');

                                    if (verified) {
                                      return Row(
                                        children: [
                                          const Text(
                                            'Verified',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(width: 10),
                                          Icon(
                                            Icons.verified_outlined,
                                            size: 18,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )
                                        ],
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () => nextPage(
                                            context: context,
                                            page: const VerificationPage()),
                                        child: Text(
                                          'Not Verified.\nClick here to verify your profile',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    }
                                  }),
                              const SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  text: 'Email address: ',
                                  style: const TextStyle(fontSize: 18),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: getEmailAddress(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
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
              );
            }
          },
        ));
  }
}
