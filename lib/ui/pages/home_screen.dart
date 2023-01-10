import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/pages/emergency.dart';
import 'package:qaizen_car_rental/ui/pages/user_profile.dart';
import 'package:qaizen_car_rental/ui/pages/settings_screen.dart';

import '../../shared/constants.dart';
import '../widgets/widgets.dart';
import '../pages/favorites.dart';
import '../pages/home_page.dart';
import '../pages/more_page.dart';
import '../pages/notifications_page.dart';
import '../pages/records.dart';
import '../pages/report_issue.dart';
import '../pages/services_page.dart';
import '../pages/terms_conditions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isThereProfileImg = false;
  var _iconColor = Constants().primaryColor();

  final List<String> _titles = ['Home', 'Services', 'Notifications', 'More'];
  final List<Widget> _pages = const [
    HomePage(),
    ServicesPage(),
    NotificationsPage(),
    MorePage()
  ];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    bool _isNightModeOn = Theme.of(context).brightness == Brightness.dark;

    if (_isNightModeOn) {
      _iconColor = Constants().primaryColorDark();
    }
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Image(
                height: 100,
                image: AssetImage('assets/qaizenlogo.png'),
                fit: BoxFit.fitHeight,
              ),
              const SizedBox(
                height: 50,
              ),
              ListTile(
                //if user created profile, use image
                //else use icon
                leading: const CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/cars/teslamodelx.jpg",
                  ),
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'User Name',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Icon(
                      Icons.verified_outlined,
                      size: 16,
                    ),
                  ],
                ),
                onTap: () => nextPage(context: context, page: const UserProfile()),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.favorite_outline_outlined,
                  color: _iconColor,
                ),
                title: const Text("Favorites"),
                onTap: () => nextPage(context: context, page: const FavoritesPage()),
              ),
              ListTile(
                leading: Icon(
                  Icons.book_outlined,
                  color: _iconColor,
                ),
                title: const Text("Records"),
                onTap: () => nextPage(context: context, page: const RecordsPage()),
              ),
              ListTile(
                leading: Icon(
                  Icons.help_outline_rounded,
                  color: _iconColor,
                ),
                title: const Text("Report Issue"),
                onTap: () => nextPage(context: context, page: const ReportIssuePage()),
              ),
              ListTile(
                leading: Icon(
                  Icons.policy_outlined,
                  color: _iconColor,
                ),
                title: const Text("Terms and Conditions"),
                onTap: () => nextPage(context: context, page: const TermsConditionsPage()),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.nights_stay_outlined),
                title: const Text("Night Mode"),
                trailing: Switch(
                  activeColor: _iconColor,
                  inactiveThumbColor: _iconColor,
                  value: _isNightModeOn,
                  onChanged: (bool value) {
                    setState(() {
                      EasyDynamicTheme.of(context).changeTheme();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(_titles[currentPage]),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => nextPage(context: context, page: const Emergency()),
              icon: const Icon(
                Icons.emergency_outlined,
              ),
              tooltip: 'Emergency',
            ),
            PopupMenuButton(
              onSelected: (position) {
                if (position == 0) {
                  //call
                  showSnackbar(
                    context: context,
                    message: "Call Permission Required.",
                    duration: 5,
                  );
                }
                if (position == 1) {
                  //WhatsApp
                }
                if (position == 2) {
                  //Settings
                  nextPage(context: context, page: const SettingsScreen());
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
                    icon: Icons.settings_outlined,
                    text: 'Settings',
                  ),
                ];
              },
            ),
          ],
        ),
        body: _pages[currentPage],
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.car_rental_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.cases_outlined),
              label: 'Services',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_outlined),
              label: 'Notifications',
            ),
            NavigationDestination(
              icon: Icon(Icons.more_outlined),
              label: 'More',
            ),
          ],
          selectedIndex: currentPage,
          onDestinationSelected: (position) {
            setState(() {
              currentPage = position;
            });
          },
          height: 60,
        ),
      ),
    );
  }
}
