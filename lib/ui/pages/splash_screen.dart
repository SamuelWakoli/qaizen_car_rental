import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'home_screen.dart';
import 'onboarding_screen.dart';

// TODO: Remove this splash screen RE: Android 12+
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () async {
      //after checking the sharedPref, if it's not
      // null, check if it returns true or false
      if (FirebaseAuth.instance.currentUser != null) {
        // signed in
        nextPageReplace(context: context, page: const HomeScreen());
      } else {
        nextPageReplace(context: context, page: const OnBoardingScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(child: Image.asset('assets/qaizenlogo.png')));
  }
}
