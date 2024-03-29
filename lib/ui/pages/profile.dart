import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/db/user.dart';
import 'package:qaizen_car_rental/ui/pages/edit_account.dart';

import '../widgets/widgets.dart';
import 'about_page.dart';
import 'terms_conditions.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String userprofileUrl =
      FirebaseAuth.instance.currentUser!.photoURL.toString();
  String userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  double tileFontSize = 18.0;

  bool isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Account"),
        actions: [
          IconButton(
            onPressed: () {
              nextPage(context: context, page: const EditAccountPage());
            },
            icon: const Icon(Icons.edit),
            tooltip: "Edit Account",
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 60,
          ),
          Center(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(userEmail)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.data!.exists) {
                    return const Text(
                        "Click the top right edit icon button to setup your account.");
                  }

                  userName = snapshot.data!["name"];
                  phoneNumber = snapshot.data!["phone"];

                  return Column(
                    children: [
                      const SizedBox(height: 26.0),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          height: 160,
                          width: 160,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: userprofileUrl,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            errorWidget: (cx, url, downloadProgress) {
                              return Center(
                                child: OutlinedButton(
                                  onPressed: () => nextPage(
                                      context: context,
                                      page: const EditAccountPage()),
                                  child: const Text(
                                    "Set Details",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      ListTile(
                        title: Text(
                          "$userName\n$userEmail\n$phoneNumber",
                          style: const TextStyle(fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                }),
          ),
          const SizedBox(height: 18.0),
          ListTile(
            leading: Icon(
              Icons.email_outlined,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('Email Verification'),
            subtitle: isEmailVerified
                ? const Text('Email verified')
                : const Text('Email not verified'),
            trailing: isEmailVerified
                ? null
                : TextButton(
                    onPressed: () async {
                      if (isEmailVerified) {
                        await FirebaseAuth.instance.currentUser!
                            .sendEmailVerification()
                            .whenComplete(
                              () => ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Verification email sent'),
                                ),
                              ),
                            );
                      }
                    },
                    child: const Text('Send Verification Email'),
                  ),
          ),
          ListTile(
            title: Text(
              "Terms of service",
              style: TextStyle(fontSize: tileFontSize),
            ),
            leading: Icon(
              Icons.policy_outlined,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              nextPage(context: context, page: const TermsConditionsPage());
            },
          ),
          ListTile(
            title: Text(
              "About us",
              style: TextStyle(fontSize: tileFontSize),
            ),
            leading: Icon(
              Icons.info_outline_rounded,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              nextPage(context: context, page: const AboutPage());
            },
          ),
          ListTile(
            title: Text(
              "Sign out",
              style: TextStyle(fontSize: tileFontSize),
            ),
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      icon: Icon(
                        Icons.logout,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: const Text("Sign Out"),
                      content: const Text("You are about to sign out from "
                          "this app. Please confirm."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            FirebaseAuth.instance.signOut();
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          },
                          child: const Text(
                            "Sign Out",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                            child: const Text("Cancel")),
                      ],
                    );
                  });
            },
          ),
          ListTile(
            title: Text(
              "Delete Account",
              style: TextStyle(fontSize: tileFontSize, color: Colors.red),
            ),
            leading: const Icon(
              Icons.person_off_outlined,
              color: Colors.red,
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text('Warning: Account Deletion'),
                      content: const Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Are you sure you want to delete your account?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Deleting your account will permanently remove all your data.',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Please carefully consider the following before proceeding:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '- All your profile information, settings, and preferences will be permanently deleted.',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            '- Any associated data, such as profile image, records, favorites, or other activities, will be irreversibly deleted and cannot be recovered.',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            // Implement the logic for confirming account deletion
                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Deleting account data...'),
                              ),
                            );

                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(userID)
                                .delete()
                                .whenComplete(
                                  () async => await FirebaseStorage.instance
                                      .ref('users_images/$userID/')
                                      .delete()
                                      .whenComplete(
                                        () async => await FirebaseAuth
                                            .instance.currentUser!
                                            .delete()
                                            .whenComplete(
                                              () async => await FirebaseAuth
                                                  .instance
                                                  .signOut()
                                                  .whenComplete(
                                                    () => Navigator.popUntil(
                                                        context,
                                                        (route) =>
                                                            route.isFirst),
                                                  ),
                                            ),
                                      ),
                                );
                          },
                          child: const Text(
                            'Delete Account',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
