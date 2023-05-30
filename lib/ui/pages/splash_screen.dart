import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'home_screen.dart';

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
      nextPageReplace(context: context, page: const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(child: Image.asset('assets/qaizenlogo.png')));
  }
}
