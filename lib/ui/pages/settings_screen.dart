import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/pages/user_profile.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/widgets.dart';
import '../pages/about_page.dart';
import '../pages/terms_conditions.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: const Text('General'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/cars/teslamodelx.jpg",
                    ),
                  ),
                  title: const Text('Profile'),
                  onPressed: (context) {
                    nextPage(context: context, page: const UserProfile());
                  },
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {},
                  initialValue: true,
                  leading: const Icon(Icons.notifications_active_outlined),
                  title: const Text('Notifications'),
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.output_outlined),
                  title: const Text('Sign Out'),
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
                  leading: const Icon(Icons.perm_device_info_outlined),
                  title: const Text("Application Version"),
                  description: const Text('1.0'),
                ),
              ],
            )
          ],
        ));
  }
}
