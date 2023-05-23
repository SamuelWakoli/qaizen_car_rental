import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helper/communication.dart';
import '../widgets/widgets.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
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
                              '+254726371714');
                          //else not granted, just show phone number
                          if (await Permission.phone.isDenied) {
                            makePhoneCall();
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
                openWhatsApp();
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
                  icon: FontAwesomeIcons.whatsapp,
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
# Privacy Policy

Last updated: May 24, 2023

This Privacy Policy describes how your personal information is collected, used, and shared when you use the Qaizen Car Rental mobile application (the "App").

## Personal Information We Collect

When you use the App, we may collect certain information about you, including:

- Your name, email address, age, years of driving experience, and images of your credentials such as National ID card and Driving Licence (if provided by you voluntarily).
- Information about how you use the App, such as your favorite vehicles, the pages you visit, and the features you use.

## How We Use Your Personal Information

We may use your personal information to:

- Provide and maintain the App, ensuring its proper functionality and continuous improvement.
- Improve and personalize the App based on your preferences and feedback.
- Communicate with you about the App, including sending you updates and notifications regarding your account, reservations, and relevant promotions.
- Monitor and analyze the usage of the App to enhance its performance, user experience, and security.

## Sharing Your Personal Information

We may share your personal information with the following entities:

- Service providers who assist us in performing various functions necessary for the operation of the App, including hosting, analytics, and marketing services.
- Law enforcement agencies, government officials, or other third parties when we are obligated to disclose your personal information by law or in response to a subpoena, court order, or similar legal process.
- Other third parties with your explicit consent or when necessary to protect our rights, safety, or property, as well as the rights, safety, or property of our users or others.

## Your Rights

You have the right to access and correct the personal information we collect about you. Additionally, you may have the right to restrict or object to certain types of processing of your personal information. Please note that these rights may be subject to legal limitations and requirements.

## Data Retention

We will retain your personal information for as long as necessary to provide you with the App's services and as required by applicable laws and regulations.

## Changes to This Privacy Policy

We reserve the right to update or modify this Privacy Policy at any time. Any changes made will be effective immediately upon posting the updated version on this page. We encourage you to review this Privacy Policy periodically for any updates.

## Contact Us

If you have any questions or concerns about this Privacy Policy or our privacy practices, please call us or email us at [+254 726 371714 | +254 728 305774 | info@qaizen.co.ke]

By using the App, you signify your acceptance and agreement to the terms of this Privacy Policy.
""")
          ],
        ),
      )),
    );
  }
}
