import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../shared/constants.dart';
import '../widgets/widgets.dart';
import 'create_account_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    nextPageReplace(context: context, page: const CreateAccountPage());
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 19.0,
    );

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
      ),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 64.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: IntroductionScreen(
        key: introKey,
        autoScrollDuration: 4500,
        pages: [
          PageViewModel(
            title: "Less paperwork 📝",
            body: "Get to reuse your preferences and save your precious time.",
            image: _buildImage('slide1.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Proper planning",
            body: "Set your dates and your location for the delivery service.",
            image: _buildImage('slide2.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Contact us anytime",
            body: "Reach to us 24/7, and we'll get you sorted.",
            image: _buildImage('slide3.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Profile Verification",
            body: "Get your profile verified to enjoy our services.",
            image: Icon(
              Icons.verified_outlined,
              color: Theme.of(context).primaryColor,
              size: 180,
            ),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context), // You can override onSkip callback

        skipOrBackFlex: 0,
        nextFlex: 0,
        isTopSafeArea: true,
        isBottomSafeArea: true,
        showSkipButton: true,
        showBackButton:
            false, //set true if showSkipButton: false //and vice versa
        //rtl: true, // Display as right-to-left
        back: Icon(Icons.arrow_back, color: Constants().primaryColor()),
        skip: Text('Skip',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Constants().primaryColor())),
        next: Icon(Icons.arrow_forward, color: Constants().primaryColor()),
        done: Text('Done',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Constants().primaryColor())),
        //curve: Curves.fastLinearToSlowEaseIn,
        curve: Curves.easeOutCirc,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: DotsDecorator(
          size: const Size(10.0, 10.0),
          activeColor: Constants().primaryColor(),
          activeSize: const Size(22.0, 10.0),
          activeShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(64.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }
}
