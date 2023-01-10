import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/pages/user_profile.dart';
import 'package:settings_ui/settings_ui.dart';

import '../widgets/widgets.dart';
import '../pages/about_page.dart';
import '../pages/terms_conditions.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    title: const Text("Visit our Office"),
                  ),
                  SettingsTile.navigation(
                    leading: const Icon(Icons.rule_sharp),
                    title: const Text("Terms and Conditions"),
                    onPressed: (context) {
                      nextPage(context: context, page: const TermsConditionsPage());
                    },
                  ),
                  SettingsTile(
                    leading: const Icon(Icons.perm_device_info_outlined),
                    title: const Text("Application Version"),
                    description: const Text('1.0'),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
