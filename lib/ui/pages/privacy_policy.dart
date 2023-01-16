import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/widgets.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse("https://wa.me/254797228948");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // can't launch url
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (position) async {
              if (position == 0) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(
                      "Call Us",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    content: const Text(
                      "We're here to help with any questions or concerns you may have. Do you want to proceed with the call?",
                      style: TextStyle(fontSize: 18),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.of(ctx).pop();

                          //call
                          //when call permission is granted:
                          await FlutterPhoneDirectCaller.callNumber(
                              '+254797228948');
                          //else not granted, just show phone number
                          if (await Permission.phone.isDenied) {
                            _makePhoneCall('+254797228948');
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: Text(
                            "okay",
                            style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: Text(
                            "cancel",
                            style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (position == 1) {
                //WhatsApp
                _openWhatsApp();
              }
              if (position == 2) {
                //Email
                String email = Uri.encodeComponent("info@qaizen.co.ke");
                String subject = Uri.encodeComponent("Privacy Policy");
                String body = Uri.encodeComponent("");
                Uri mail =
                    Uri.parse("mailto:$email?subject=$subject&body=$body");
                await launchUrl(mail);
              }
            },
            itemBuilder: (context) {
              return [
                optionMenuItem(
                  position: 0,
                  icon: Icons.call_outlined,
                  color: Colors.lightBlue,
                  text: 'Call Us',
                ),
                optionMenuItem(
                  position: 1,
                  icon: Icons.whatsapp,
                  color: Colors.green,
                  text: 'WhatsApp',
                ),
                optionMenuItem(
                  position: 2,
                  icon: Icons.mail_outline_rounded,
                  text: 'Email Us',
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            Text(style: TextStyle(fontSize: 16), """
At Qaizen Car Rental, we take the privacy of our users seriously. This policy outlines the types of personal information we collect, how we use it, and your rights in relation to it.

Information We Collect:

Personal information you provide to us directly, such as your name, contact information, and images of your credentials.
Information about your use of our app, such as most liked vehicles and booking history.
Location data, in order to provide you with relevant car rental options and to improve the functionality of the app.

Use of Information:

We use your personal information to process your bookings, payments, and to communicate with you regarding your account and reservations.
We use your location data to facilitate delivery option, organize events and to improve the functionality of the app.
We may use your information for marketing and promotional purposes, but only with your explicit consent.

Sharing of Information:

We may share your personal information with third-party service providers, such as payment processors (example: M-pesa), and marketing partners, but only to the extent necessary to provide the services offered by our app.
We may also share your information in response to legal requests and as required by law.
We will not sell or rent your personal information to any third party without your explicit consent.

Security:

We take appropriate measures to protect the security and confidentiality of your personal information.
However, please note that no method of transmission over the internet or method of electronic storage is completely secure.

Changes to this Policy:

We may update this policy from time to time. We will notify you of any changes by posting the new policy on our app.


If you have any questions or concerns about our privacy policy, please call us or email us at [+254 726 371714 | +254 728 305774 | info@qaizen.co.ke].
By using our app, you consent to our collection, use, and sharing of your information as described in this policy.""")
          ],
        ),
      )),
    );
  }
}
