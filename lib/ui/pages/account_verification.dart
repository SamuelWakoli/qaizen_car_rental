import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qaizen_car_rental/ui/pages/acc_verification_page1.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Verification'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Icon(
                    Icons.verified_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 128,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  """
All our clients must be verified. Why?
          1. To avoid fraud.
          2. To avoid unlawful transactions.
          3. To improve client experience.
          
For self drive service, you are required to provide all the details needed and submit them. This includes personal details and images of your credentials. We will review your details within 6 hours.
Click "Get Started" to proceed.
""",
                  style: TextStyle(fontSize: 17),
                ),
                Text.rich(
                  TextSpan(
                      text:
                          "For all other services (Chauffeured, Corporate, Weddings, etc), please",
                      style: const TextStyle(fontSize: 17),
                      children: <TextSpan>[
                        TextSpan(
                            text: " call us ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text(
                                      "Call Us",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    content: const Text(
                                      "Thank you for choosing our car rental app. We're here to help with any questions or concerns you may have. Do you want to proceed with the call?",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () async {
                                          Navigator.of(ctx).pop();

                                          //call
                                          //when call permission is granted:
                                          await FlutterPhoneDirectCaller
                                              .callNumber('+254797228948');
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
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(),
                                        child: Container(
                                          padding: const EdgeInsets.all(14),
                                          child: Text(
                                            "cancel",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        const TextSpan(
                          text: "to get verified.",
                          style: TextStyle(fontSize: 17),
                        )
                      ]),
                ),
                const SizedBox(height: 10),
                const Text("Please note that this process needs a strong internet connection when uploading your images.", style: TextStyle(fontSize: 17),),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () => nextPage(
                        context: context, page: const AccVerificationPage1()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Get Started',
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor)),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.arrow_forward,
                          size: 32,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    )),

              ],
            ),
          ],
        ),
      )),
    );
  }
}
