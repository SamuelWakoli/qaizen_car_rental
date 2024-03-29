import 'dart:async';

import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qaizen_car_rental/ui/pages/auth_gate.dart';
import 'package:qaizen_car_rental/ui/pages/profile.dart';
import 'package:qaizen_car_rental/ui/pages/search_page.dart';
import 'package:qaizen_car_rental/ui/pages/settings_screen.dart';

import '../../db/user.dart';
import '../../helper/communication.dart';
import '../../helper/rate_card.dart';
import '../pages/favorites.dart';
import '../pages/home_page.dart';
import '../pages/more_page.dart';
import '../pages/records.dart';
import '../pages/report_issue.dart';
import '../pages/services_page.dart';
import '../pages/terms_conditions.dart';
import '../widgets/widgets.dart';
import 'current_service.dart';
import 'view_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int currentPage = 0;

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  static const int totalPage = 5;

  Widget _titles({required BuildContext context, required int currentIndex}) {
    // appbar title:
    final List<Widget> titles = [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Card(
              elevation: 4,
              shape: CircleBorder(
                  eccentricity: 1,
                  side: BorderSide(
                    style: BorderStyle.solid,
                    color: Theme.of(context).primaryColor,
                  )),
              child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: Image.asset('assets/ic_launcher.png')),
            ),
          ),
          const SizedBox(width: 20),
          const Text("Home")
        ],
      ),
      const Text('Services'),
      const Text('Current Service'),
      const Text('Favorites'),
      const Text('More')
    ];

    return titles[currentIndex];
  }

  // icons for bottomNav
  List<IconData> icons = [
    Icons.car_rental_outlined,
    Icons.cases_outlined,
    Icons.fact_check_outlined,
    Icons.favorite_outline_rounded,
    Icons.more_outlined,
  ];

  // labels for bottom navigation
  static const List<String> names = [
    'Home',
    'Services',
    'Current',
    'Favorites',
    'More',
  ];

  // body
  final List<Widget> _pages = const [
    HomePage(),
    ServicesPage(),
    CurrentServicePage(),
    FavoritesPage(),
    MorePage()
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      var snapshot = await fireStoreUserData.get();

      bool dataAwaiting = false, dataVerified = false;
      if (snapshot.exists && snapshot.data()!.isNotEmpty) {
        setState(() {
          notificationOn = snapshot.get('notifications');
        });
      } else {
        dataAwaiting = false;
        dataVerified = false;
        favoriteVehicles = [];
      }

      updateDbHasData(dataAwaiting);
      updateVerification(dataVerified);
    });
    getRateCardUrl();
  }

  void updateDbHasData(bool value) => setState(() => dbHasData = value);

  void updateVerification(bool value) => setState(() => isVerified = value);
  String userprofileUrl =
      FirebaseAuth.instance.currentUser!.photoURL.toString();

  Widget _getProfile() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: SizedBox(
            height: 48,
            width: 48,
            child: userprofileUrl != "null"
                ? CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: userprofileUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                      value: downloadProgress.progress,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.account_circle_outlined),
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
                    errorWidget: (context, url, error) => const Icon(
                      Icons.account_circle_outlined,
                      size: 46,
                    ),
                  )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark;

    //if db has data, return this screen
    return Scaffold(
      drawer: Drawer(
        elevation: 16,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Card(
                elevation: 8,
                shape: CircleBorder(
                    eccentricity: 1,
                    side: BorderSide(
                        style: BorderStyle.solid,
                        color: Theme.of(context).primaryColor)),
                child: CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/ic_launcher.png')),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Card(
                elevation: 0,
                child: ListTile(
                  //if user created profile, use image
                  //else use icon
                  leading: _getProfile(),
                  title: Text(
                    FirebaseAuth.instance.currentUser!.displayName.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    FirebaseAuth.instance.currentUser!.email.toString(),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onTap: () =>
                      nextPage(context: context, page: const UserProfile()),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 0,
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    ListTile(
                      leading: Icon(
                        Icons.price_change_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: const Text("Rate Card"),
                      onTap: () {
                        currentImageUrl = rateCardUrl;
                        nextPage(context: context, page: const ViewImage());
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.book_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: const Text("Records"),
                      onTap: () =>
                          nextPage(context: context, page: const RecordsPage()),
                    ),
                    const Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.help_outline_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: const Text("Report Issue"),
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser != null) {
                          nextPage(
                              context: context, page: const ReportIssuePage());
                        } else {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  icon: Icon(
                                    Icons.account_circle_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  title: const Text("Authentication Required"),
                                  content:
                                      const Text("Please sign in to continue."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(ctx);
                                          nextPage(
                                              context: context,
                                              page: const AuthGate());
                                        },
                                        child: const Text("Sign In")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(ctx);
                                        },
                                        child: const Text("Cancel")),
                                  ],
                                );
                              });
                        }
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.rule_sharp,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: const Text("Terms of Service"),
                      onTap: () => nextPage(
                          context: context, page: const TermsConditionsPage()),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              onTap: () {
                setState(() {
                  EasyDynamicTheme.of(context).changeTheme();
                });
              },
              title: Text(isDarkModeOn ? "Light Theme" : "Dark Theme"),
              leading: Icon(isDarkModeOn ? Icons.sunny : Icons.dark_mode),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 2,
        title: _titles(context: context, currentIndex: currentPage),
        centerTitle: true,
        actions: [
          if (currentPage == 0)
            IconButton(
                tooltip: "Search",
                onPressed: () =>
                    nextPage(context: context, page: const SearchPage()),
                icon: const Icon(Icons.search)),
          PopupMenuButton(
            position: PopupMenuPosition.under,
            elevation: 8,
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
                      TextButton(
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
                            "Yes",
                            style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: Text(
                            "No",
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
                //Report Issue
                if (FirebaseAuth.instance.currentUser != null) {
                  nextPage(context: context, page: const ReportIssuePage());
                } else {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          icon: Icon(
                            Icons.account_circle_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: const Text("Authentication Required"),
                          content: const Text("Please sign in to continue."),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  nextPage(
                                      context: context, page: const AuthGate());
                                },
                                child: const Text("Sign In")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                },
                                child: const Text("Cancel")),
                          ],
                        );
                      });
                }
              }
              if (position == 3) {
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
                  icon: Icons.help_outline_rounded,
                  color: Theme.of(context).primaryColor,
                  text: 'Report Issue',
                ),
                optionMenuItem(
                  position: 3,
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
        currentIndex: currentPage,
        totalLength: totalPage,
        transitionType: TransitionType.fade,
        transitionDuration: const Duration(seconds: 1),
        transitionCurve: Curves.ease,
      ),
      bottomNavigationBar: _getBottomBar(),
    );
  }

  Widget _getBottomBar() {
    return BottomNavigationBar(
      currentIndex: currentPage,
      onTap: (index) {
        setState(() {
          currentPage = index;
        });
      },
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.shifting,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      //selectedLabelStyle: const TextStyle(fontSize: 12),
      items: List.generate(
        totalPage,
        (index) => BottomNavigationBarItem(
          icon: Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icons[index]),
              )),
          label: names[index],
          tooltip: names[index],
        ),
      ),
    );
  }

  Widget _getBody(int index) {
    return Scaffold(
      body: _pages[currentPage],
    );
  }
}
