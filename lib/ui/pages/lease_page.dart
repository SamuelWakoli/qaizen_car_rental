import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class LeasePage extends StatefulWidget {
  const LeasePage({Key? key}) : super(key: key);

  @override
  State<LeasePage> createState() => _LeasePageState();
}

class _LeasePageState extends State<LeasePage> {
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
        title: Text('Need extra income?'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                """Make up to Ksh. 300,000/month starting from Ksh. 30,000 with your vehicle.""",
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                "Partner with us for either short term or long term period. Your income will be determined depending on the type of vehicle and the year of production, during the signing of the contract.",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                """
REQUIREMENTS
~ The vehicle should be 1300CC and above.
~ Copy of the logbook.
~ Copy of national ID card.
~ Comprehensive Cover.

Ensure the vehicle is in a good condition and has a tracking device installed to enhance security.
Call us to get started.

""",
                style: TextStyle(fontSize: 18),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ConstrainedBox(constraints: BoxConstraints(minHeight: 10)),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(
                              "Call Us",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
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
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: 32,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 12),
                          Text('Call US',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor)),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
