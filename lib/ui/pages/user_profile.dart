import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/pages/about_page.dart';
import 'package:qaizen_car_rental/ui/pages/terms_conditions.dart';

import '../widgets/widgets.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  double tileFontSize = 18.0;

  String userprofileUrl =
      FirebaseAuth.instance.currentUser!.photoURL.toString();

  String userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  String username = FirebaseAuth.instance.currentUser!.displayName.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Account"),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 28.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                height: 200,
                width: 200,
                child: CachedNetworkImage(
                  imageUrl: userprofileUrl,
                  fit: BoxFit.cover,
                  errorWidget: (cx, url, downloadProgress) {
                    return Icon(
                      Icons.account_circle_outlined,
                      size: 120,
                      color: Theme.of(context).primaryColor,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 14.0),
            ListTile(
              title: Text(
                "$username\n$userEmail",
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 18.0),
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
                            onPressed: () {
                              // Implement the logic for confirming account deletion
                              Navigator.of(context).pop();
                              // Perform account deletion here
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
      ),
    );
  }
}
