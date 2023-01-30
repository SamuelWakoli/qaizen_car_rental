import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qaizen_car_rental/shared/theming.dart';
import 'package:qaizen_car_rental/ui/pages/splash_screen.dart';

import 'firebase_options.dart';
//init the app
//init firebase

//start with splash
//if user is not signed in, show onboarding screen
//then login page.

//if user is signed in, from splash screen, go home
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(
        clientId:
            '166127006317-sb4n54vsbjpu06ghshefdkf5apidbpt5.apps.googleusercontent.com'),
    // ... other providers
  ]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(EasyDynamicThemeWidget(child: const MyApp()));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qaizen Car Rental',
      debugShowCheckedModeBanner: false,
      //if user is signed in, set home: to MainScreen.
      //else set home: OnboardingScreen, then LoginScreen
      home: const MainScreen(),
      theme: Theming().lightThemeData,
      darkTheme: Theming().darkThemeData,
      themeMode: EasyDynamicTheme.of(context).themeMode,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
