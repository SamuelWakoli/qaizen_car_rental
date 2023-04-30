import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qaizen_car_rental/shared/theming.dart';
import 'package:qaizen_car_rental/ui/pages/splash_screen.dart';

import 'firebase_options.dart';

/// This is the starting point of the app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// The app uses Email and GoogleProvider to sign in.
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(
        clientId:
            '166127006317-sb4n54vsbjpu06ghshefdkf5apidbpt5.apps.googleusercontent.com'),
    // ... other providers can be added here if necessary
  ]);

  /// This prevents the app from rotating to landscape mode.
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
      home: const SplashScreen(),
      theme: Theming().lightThemeData,
      darkTheme: Theming().darkThemeData,
      themeMode: EasyDynamicTheme.of(context).themeMode,
    );
  }
}
