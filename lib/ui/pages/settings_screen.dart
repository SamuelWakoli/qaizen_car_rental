import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../db/user.dart';
import '../pages/about_page.dart';
import '../pages/terms_conditions.dart';
import '../widgets/widgets.dart';
import 'auth_gate.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _openLink(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // can't launch url
    }
  }

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
          title: const Text('Settings'),
          centerTitle: true,
        ),
        body: SettingsList(
          lightTheme:
              const SettingsThemeData(settingsListBackground: Colors.white),
          sections: [
            SettingsSection(
              title: const Text('General'),
              tiles: <SettingsTile>[
                SettingsTile.switchTile(
                  onToggle: (value) async {
                    Map<String, dynamic> data = {'notifications': value};
                    await UserData.update(data); //update data in db
                    setState(() {
                      notificationOn = value;
                    });
                    String messageText = value ? "on" : "off";
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Notifications turned $messageText'),
                      ),
                    );
                  },
                  initialValue: notificationOn,
                  activeSwitchColor: Theme.of(context).primaryColor,
                  leading: const Icon(Icons.notifications_active_outlined),
                  title: const Text('Notifications'),
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.output_outlined),
                  title: const Text('Sign Out'),
                  onPressed: (context) {
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
                ),
              ],
            ),
            SettingsSection(
              title: const Text("About"),
              tiles: [
                SettingsTile(
                  leading: const Icon(Icons.info_outline_rounded),
                  title: const Text("Qaizen Car Rental"),
                  onPressed: (context) {
                    nextPage(context: context, page: const AboutPage());
                  },
                ),
                SettingsTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: const Text("Our Office"),
                  onPressed: (context) => _openLink(
                      "https://www.google.com/maps/place/Qaizen+Car+Rentals/@-1.3084742,36.907569,17z/data=!3m1!4b1!4m5!3m4!1s0x182f13aac0a7bc05:0x431e46af05249d3e!8m2!3d-1.3084742!4d36.9097631"),
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.rule_sharp),
                  title: const Text("Terms and Conditions"),
                  onPressed: (context) => nextPage(
                      context: context, page: const TermsConditionsPage()),
                ),
                SettingsTile(
                  leading: const Icon(FontAwesomeIcons.code),
                  title: const Text('Developer Contact'),
                  onPressed: (context) {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: const Text('Developer Contact'),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    //when call permission is granted:
                                    await FlutterPhoneDirectCaller.callNumber(
                                        '+254797228948');
                                    //else not granted, just show phone number
                                    if (await Permission.phone.isDenied) {
                                      _makePhoneCall('+254797228948');
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.phone_outlined,
                                    color: Colors.lightBlue,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _openWhatsApp();
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.whatsapp,
                                    color: Colors.green,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    //Email
                                    String email = Uri.encodeComponent(
                                        "info@qaizen.co.ke");
                                    String subject =
                                        Uri.encodeComponent("Developer Contact");
                                    String body = Uri.encodeComponent("");
                                    Uri mail = Uri.parse(
                                        "mailto:$email?subject=$subject&body=$body");
                                    await launchUrl(mail);
                                  },
                                  icon: const Icon(Icons.email_outlined),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                ),
                SettingsTile(
                  leading: const Icon(Icons.perm_device_info_outlined),
                  title: const Text("Application Version"),
                  description: const Text('1.0.0'),
                ),
              ],
            )
          ],
        ));
  }
}
