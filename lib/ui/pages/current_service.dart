import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qaizen_car_rental/helper/communication.dart';

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
            .collection('records')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.filter_none_rounded,
                  size: 64,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 20),
                Text(
                  "No active service",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ],
            );
          }

          if (snapshot.data!.docs.last['ended'] == true) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.filter_none_rounded,
                    size: 64,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "No active service",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            );
          }

          dynamic document = snapshot.data!.docs.last;

          List<String> vehicleIDs = (document['vehicles list'] as String)
              .split(',')
              .map((e) => e.trim())
              .toList();

          Future<String> getVehicleNames() async {
            String names = "";
            for (var id in vehicleIDs) {
              var snapshot = await FirebaseFirestore.instance
                  .collection('vehicles')
                  .doc(id)
                  .get();
              String currentName = snapshot["name"];

              names = "$names$currentName, ";
            }

            // Remove trailing comma and any leading/trailing whitespace
            return names.trim().replaceAll(RegExp(r',\s*$'), '');
          }

          String formatDateTime(String dateTimeString) {
            final DateTime dateTime = DateTime.parse(dateTimeString);
            final DateFormat formatter = DateFormat('hh:mm a | dd/MM/yyyy');
            return formatter.format(dateTime);
          }

          Widget getProfile() {
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
                          leading: getProfile(),
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
                            title: const Text("Type"),
                            subtitle: Text(document['type']),
                          )),
                      const SizedBox(height: 4),
                      Card(
                        elevation: 0,
                        child: ListTile(
                          title: const Text("Vehicle(s)"),
                          subtitle: FutureBuilder<String>(
                            future: getVehicleNames(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text("Loading...");
                              } else if (snapshot.hasError) {
                                return const Text(
                                    "Error loading vehicle names.");
                              } else {
                                return Text(snapshot.data ?? "");
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Card(
                        elevation: 0,
                        child: ListTile(
                          title: const Text("Approved on:"),
                          subtitle: Text(formatDateTime(document['starts'])),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Card(
                          elevation: 0,
                          child: ListTile(
                            title: const Text("Duration"),
                            subtitle: Text(document['duration'] + " Day(s)"),
                          )),
                      const SizedBox(height: 4),
                      RemainingTimeWidget(
                        starts: document['starts'],
                        duration: int.parse(document['duration']),
                        currentServiceDocID: document['docID'],
                      ),
                      const SizedBox(height: 24),
                      Text.rich(
                        TextSpan(
                          text: "Tip: ",
                          children: [
                            TextSpan(
                                text: "Call us",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Theme.of(context).primaryColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => makePhoneCall()),
                            const TextSpan(text: " to "),
                            const TextSpan(
                                text:
                                    "extend, terminate a service or swap a vehicle.",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class RemainingTimeWidget extends StatefulWidget {
  final String starts;
  final int duration;
  final String currentServiceDocID;

  const RemainingTimeWidget(
      {super.key,
      required this.starts,
      required this.duration,
      required this.currentServiceDocID});

  @override
  RemainingTimeWidgetState createState() => RemainingTimeWidgetState();
}

class RemainingTimeWidgetState extends State<RemainingTimeWidget> {
  late DateTime startTime;
  late int durationInDays;
  late Duration remainingDuration;
  late Color textColor;
  String userEmail = FirebaseAuth.instance.currentUser!.email.toString();

  @override
  void initState() {
    super.initState();
    startTime = DateTime.parse(widget.starts);
    durationInDays = widget.duration;
    remainingDuration = calculateRemainingDuration();
    updateFireStore(remainingDuration);
    textColor = determineTextColor(remainingDuration);
    updateRemainingDuration();
  }

  Duration calculateRemainingDuration() {
    final DateTime serviceEndTime =
        startTime.add(Duration(days: durationInDays));
    return serviceEndTime.difference(DateTime.now());
  }

  Color determineTextColor(Duration duration) {
    if (duration < const Duration(hours: 2)) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  updateFireStore(Duration duration) async {
    if (duration < const Duration(hours: 0)) {
      // use < sign because Duration is never equal
      Map<String, dynamic> data = {
        'ended': true,
      };

      if (widget.currentServiceDocID != '') {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userEmail)
            .collection('records')
            .doc(widget.currentServiceDocID)
            .update(data);
      }
    }
  }

  String formatRemainingDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);
    return '$hours hrs $minutes mins $seconds secs';
  }

  void updateRemainingDuration() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        remainingDuration = calculateRemainingDuration();
        textColor = determineTextColor(remainingDuration);
        updateRemainingDuration();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
          title: const Text("Remaining Time"),
          subtitle: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: formatRemainingDuration(remainingDuration),
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
