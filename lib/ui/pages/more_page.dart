import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaizen_car_rental/ui/pages/privacy_policy.dart';
import 'package:qaizen_car_rental/ui/pages/referral_program.dart';
import 'package:qaizen_car_rental/ui/pages/view_image.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/widgets.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  Future<void> _openLink(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // can't launch url
    }
  }

  _onShareData(context, text, subject) async {
    final RenderBox box = context.findRenderObject();
    {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  Widget boxItem({
    required VoidCallback onTap, // Use VoidCallback instead of void
    required IconData iconData,
    required String text,
  }) =>
      Card(
        elevation: 0,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: onTap,
            highlightColor: Colors.transparent,
            child: SizedBox(
              height: 126,
              width: 160,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      iconData,
                      color: Theme.of(context).primaryColor,
                      size: 56,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      text,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 4),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    child: Image.asset(
                      'assets/slide4.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              surfaceTintColor: null,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            boxItem(
                              text: 'Qaizen Website',
                              iconData: FontAwesomeIcons.chrome,
                              onTap: () =>
                                  _openLink('https://www.qaizen.co.ke/'),
                            ),
                            boxItem(
                                onTap: () => _openLink(
                                    "https://www.google.com/maps/place/Qaizen+Car+Rentals/@-1.3084742,36.907569,17z/data=!3m1!4b1!4m5!3m4!1s0x182f13aac0a7bc05:0x431e46af05249d3e!8m2!3d-1.3084742!4d36.9097631"),
                                iconData: Icons.location_on_outlined,
                                text: 'Visit Office'),
                          ]),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            boxItem(
                                onTap: () => _onShareData(
                                    context,
                                    "https://play.google.com/store/apps/details?id=com.qaizencarrental.qaizen_car_rental",
                                    'Qaizen Car Rental App Link'),
                                iconData: Icons.link,
                                text: 'Share App Link'),
                            boxItem(
                                onTap: () => nextPage(
                                    context: context,
                                    page: const PrivacyPolicyPage()),
                                iconData: Icons.lock_person_outlined,
                                text: 'Privacy Policy'),
                          ]),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            boxItem(
                                onTap: () => nextPage(
                                    context: context,
                                    page: const ReferralProgramPage()),
                                iconData: Icons.people_alt_outlined,
                                text: 'Referral Program'),
                            boxItem(
                                onTap: () {
                                  currentImageUrl =
                                      'https://firebasestorage.googleapis.com/v0/b/qaizen-car-rental-2023.appspot.com/o/lease_with_us.jpeg?alt=media&token=364f8daf-994c-4492-8283-b20f97afd5b8';
                                  nextPage(
                                      context: context,
                                      page: const ViewImage());
                                },
                                iconData: Icons.handshake_outlined,
                                text: 'Lease With Us'),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 1,
              surfaceTintColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Text('Social Media Accounts'),
                    // SizedBox(
                    //   height: 4,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          child: InkWell(
                            onTap: () => _openLink(
                                "https://www.instagram.com/qaizencarrental/?hl=en"),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: FaIcon(
                                FontAwesomeIcons.instagram,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Card(
                          child: InkWell(
                              onTap: () =>
                                  _openLink("https://wa.me/254797228948"),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FaIcon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.green,
                                  size: 32,
                                ),
                              )),
                        ),
                        const SizedBox(width: 30),
                        Card(
                          child: InkWell(
                            onTap: () => _openLink(
                                'https://www.facebook.com/qaizen.carrental/'),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: FaIcon(
                                FontAwesomeIcons.facebook,
                                color: Colors.indigo,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Card(
                          child: InkWell(
                            onTap: () => _openLink(
                                'https://twitter.com/qaizencarrental'),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: FaIcon(
                                FontAwesomeIcons.twitter,
                                color: Colors.blue,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
