import 'dart:async';

import 'package:flutter/material.dart';

import '../../helper/helper_function.dart';
import '../widgets/widgets.dart';
import 'home_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //is user signed in?
  Future<bool?> isUserSignedIn = HelperFunctions.getUserSignedInStatus();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      //after checking the sharedPref, if it's not
      // null, check if it returns true or false
      if (await isUserSignedIn != null) {
        await isUserSignedIn == false
            ? nextPageReplace(context: context, page: const OnBoardingScreen())
            : nextPageReplace(context: context, page: const HomeScreen());
      } else {
        //else it is null
        nextPageReplace(context: context, page: const OnBoardingScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset('assets/qaizenlogo.png')));
  }
}
