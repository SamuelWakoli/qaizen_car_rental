import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'profile.dart';

class CurrentServicePage extends StatefulWidget {
  const CurrentServicePage({super.key});

  @override
  State<CurrentServicePage> createState() => _CurrentServicePageState();
}

class _CurrentServicePageState extends State<CurrentServicePage> {
  @override
  Widget build(BuildContext context) {
    String userprofileUrl =
        FirebaseAuth.instance.currentUser!.photoURL.toString();
    String userEmail = FirebaseAuth.instance.currentUser!.email.toString();

    return StreamBuilder(
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
            return const Text("No active service");
          }

          Widget _getProfile() {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: SizedBox(
                    height: 48,
                    width: 48,
                    child: userprofileUrl != "null"
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: userprofileUrl,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                              value: downloadProgress.progress,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.account_circle_outlined),
                          )
                        : CachedNetworkImage(
                            imageUrl:
                                "https://firebasestorage.googleapis.com/v0/b/qaizen-car-rental-2023.appspot.com/o/app_assets%2FprofileHolder.png?alt=media&token=4eaddbdf-bce9-4421-b2bb-6efd7d570dc9",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                              value: downloadProgress.progress,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.account_circle_outlined,
                              size: 46,
                            ),
                          )),
              ),
            );
          }

          return Card(
            elevation: 1,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 0,
                        child: ListTile(
                          //if user created profile, use image
                          //else use icon
                          leading: _getProfile(),
                          title: Text(
                            FirebaseAuth.instance.currentUser!.displayName
                                .toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            FirebaseAuth.instance.currentUser!.email.toString(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          onTap: () => nextPage(
                              context: context, page: const UserProfile()),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Card(
                          elevation: 0,
                          child: ListTile(
                            title: Text("Type"),
                            subtitle: Text("Self Drive"),
                          )),
                      const SizedBox(height: 4),
                      Card(
                          elevation: 0,
                          child: ListTile(
                            title: Text("Vehicle"),
                            subtitle: Text("Honda Vezel"),
                          )),
                      const SizedBox(height: 4),
                      Card(
                          elevation: 0,
                          child: ListTile(
                            title: Text("Approved on Date"),
                            subtitle: Text("11/02/2024 | 11:33"),
                          )),
                      const SizedBox(height: 4),
                      Card(
                          elevation: 0,
                          child: ListTile(
                            title: Text("Days"),
                            subtitle: Text("2"),
                          )),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 100, child: Divider()),
                          SizedBox(width: 20),
                          Text(
                            "Requests",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(width: 20),
                          SizedBox(width: 100, child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Extend Service"),
                            ],
                          )),
                      const SizedBox(height: 4),
                      ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Swap Vehicle"),
                            ],
                          )),
                      const SizedBox(height: 4),
                      OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Terminate Service"),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
