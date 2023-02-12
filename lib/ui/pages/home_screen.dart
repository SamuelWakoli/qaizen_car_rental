import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qaizen_car_rental/ui/pages/account_verification.dart';
import 'package:qaizen_car_rental/ui/pages/emergency.dart';
import 'package:qaizen_car_rental/ui/pages/settings_screen.dart';
import 'package:qaizen_car_rental/ui/pages/user_profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../db/user.dart';
import '../../shared/constants.dart';
import '../pages/favorites.dart';
import '../pages/home_page.dart';
import '../pages/more_page.dart';
import '../pages/notifications_page.dart';
import '../pages/records.dart';
import '../pages/report_issue.dart';
import '../pages/services_page.dart';
import '../pages/terms_conditions.dart';
import '../widgets/widgets.dart';
import 'active_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // String getUserName() {
  //   if (FirebaseAuth.instance.currentUser!.displayName!.isNotEmpty) {
  //     return FirebaseAuth.instance.currentUser!.displayName!.toString();
  //   } else {
  //     return FirebaseAuth.instance.currentUser!.email!.toString();
  //   }
  // }

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

  static const int totalPage = 4;

  // appbar title:
  final List<Widget> _titles = [
    CircleAvatar(
        radius: 22,
        backgroundColor: Colors.white,
        child: Image.asset('assets/ic_launcher.png')),
    const Text('Services'),
    const Text('Notifications'),
    const Text('More')
  ];

  // icons for bottomNav
  List<IconData> icons = [
    Icons.car_rental_outlined,
    Icons.cases_outlined,
    Icons.notifications_outlined,
    Icons.more_outlined,
  ];

  // labels for bottom navigation
  static const List<String> names = [
    'Home',
    'Services',
    'Notifications',
    'More',
  ];

  // body
  final List<Widget> _pages = const [
    HomePage(),
    ServicesPage(),
    NotificationsPage(),
    MorePage()
  ];

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(), () async {
      var snapshot = await UserData.get();

      bool data;
      if (snapshot.exists && snapshot.data()!.isNotEmpty) {
        data = true;
      } else {
        data = false;
      }

      updateDbHasData(data);
    });
  }

  void updateDbHasData(bool value) {
    setState(() {
      dbHasData = value;
    });
  }

  Widget _getImage() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: SizedBox(
            height: 48,
            width: 48,
            child: dbHasData
                ? StreamBuilder(
                    stream: UserData.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String profileImageURL =
                            snapshot.data!.get('passport URL').toString();
                        // if profileImageURL empty, use holder image
                        if (profileImageURL.isEmpty) {
                          profileImageURL =
                              "https://firebasestorage.googleapis.com/v0/b/qaizen-car-rental-2023.appspot.com/o/app_assets%2FprofileHolder.png?alt=media&token=4eaddbdf-bce9-4421-b2bb-6efd7d570dc9";
                        }

                        return CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: profileImageURL,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                            value: downloadProgress.progress,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error_outline),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
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
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error_outline),
                  )),
      ),
    );
  }

  var _iconColor = Constants().primaryColor();

  @override
  Widget build(BuildContext context) {
    bool isNightModeOn = Theme.of(context).brightness == Brightness.dark;

    if (isNightModeOn) {
      _iconColor = Constants().primaryColorDark();
    }

    //if db has data, return this screen
    return Scaffold(
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
              leading: _getImage(),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getUserName(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  dbHasData
                      ? StreamBuilder(
                          stream: UserData.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.get('verified')) {
                                return Icon(
                                  Icons.verified_outlined,
                                  size: 18,
                                  color: Theme.of(context).primaryColor,
                                );
                              } else {
                                return const Text(
                                  'awaiting verification',
                                );
                              }
                            } else {
                              return const SizedBox();
                            }
                          })
                      : const Text(
                          'click here to verify your profile',
                        ),
                ],
              ),
              onTap: () => dbHasData
                  ? nextPage(context: context, page: const UserProfile())
                  : nextPage(context: context, page: const VerificationPage()),
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.supervised_user_circle_outlined,
                color: _iconColor,
              ),
              title: const Text("Active Service"),
              onTap: () =>
                  nextPage(context: context, page: const ActiveService()),
            ),
            ListTile(
              leading: Icon(
                Icons.favorite_outline_outlined,
                color: _iconColor,
              ),
              title: const Text("Favorites"),
              onTap: () =>
                  nextPage(context: context, page: const FavoritesPage()),
            ),
            ListTile(
              leading: Icon(
                Icons.book_outlined,
                color: _iconColor,
              ),
              title: const Text("Records"),
              onTap: () =>
                  nextPage(context: context, page: const RecordsPage()),
            ),
            ListTile(
              leading: Icon(
                Icons.help_outline_rounded,
                color: _iconColor,
              ),
              title: const Text("Report Issue"),
              onTap: () =>
                  nextPage(context: context, page: const ReportIssuePage()),
            ),
            ListTile(
              leading: Icon(
                Icons.policy_outlined,
                color: _iconColor,
              ),
              title: const Text("Terms and Conditions"),
              onTap: () =>
                  nextPage(context: context, page: const TermsConditionsPage()),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.nights_stay_outlined),
              title: const Text("Night Mode"),
              trailing: Switch(
                inactiveThumbColor: _iconColor,
                activeTrackColor: Theme.of(context).primaryColor,
                value: isNightModeOn,
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
        title: _titles[_currentPage],
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                nextPage(context: context, page: const Emergency()),
            icon: const Icon(
              Icons.emergency_outlined,
            ),
            tooltip: 'Emergency',
          ),
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
                  icon: FontAwesomeIcons.whatsapp,
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
      body: BottomBarPageTransition(
        builder: (_, index) => _getBody(index),
        currentIndex: _currentPage,
        totalLength: totalPage,
        transitionType: TransitionType.fade,
        transitionDuration: const Duration(milliseconds: 100),
        transitionCurve: Curves.ease,
      ),
      bottomNavigationBar: _getBottomBar(),
    );
  }

  Widget _getBottomBar() {
    return BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          _currentPage = index;
          setState(() {});
        },
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        type: BottomNavigationBarType.fixed,
        items: List.generate(
            totalPage,
            (index) => BottomNavigationBarItem(
                  icon: Icon(icons[index]),
                  label: names[index],
                )));
  }

  Widget _getBody(int index) {
    return Scaffold(
      body: _pages[_currentPage],
    );
  }
}
