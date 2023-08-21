import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'db/user.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission(alert: true, announcement: true);
    fCMToken = (await _firebaseMessaging.getToken())!;
    print("FCM TOKEN:   $fCMToken");

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Future.delayed(const Duration(seconds: 1), () {
        if (message.notification?.title == "Requested service approved") {
          // use this in future
        }
      });
    });
  }
}

// late StreamSubscription<DocumentSnapshot> documentStream;
//
// void startListening() {
//   final collectionReference = FirebaseFirestore.instance
//       .collection("users")
//       .doc(userID)
//       .collection("records");
//
//   documentStream = collectionReference.snapshots().listen((snapshot) {
//     if (snapshot.docs.isNotEmpty) {
//       final lastDocument = snapshot.docs.last;
//       final notificationStatus = lastDocument.data()['ended'];
//
//       if (notificationStatus == false) {
//         // Send an FCM notification to trigger the background message handler
//         // sendNotification();
//       }
//     }
//   }) as StreamSubscription<DocumentSnapshot<Object?>>;
// }

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("NOTIFICATION TITLE ${message.notification?.title}");
  print("NOTIFICATION BODY ${message.notification?.body}");
  print("PAYLOAD ${message.data}");
}

// Future<void> sendNotification() async {
//   try {
//     // Create the notification
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 0, // Notification ID
//         channelKey: 'alerts',
//         title: 'Requested service approved', // Notification title
//         body: 'Your requested service has been approved.', // Notification body
//       ),
//     );
//
//     print("Local notification sent successfully.");
//   } catch (e) {
//     print("Error sending local notification: $e");
//   }
}