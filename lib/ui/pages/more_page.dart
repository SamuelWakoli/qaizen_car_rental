import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaizen_car_rental/ui/pages/privacy_policy.dart';
import 'package:qaizen_car_rental/ui/pages/referral_program.dart';
import 'package:qaizen_car_rental/ui/pages/user_profile.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../db/user.dart';
import '../../shared/constants.dart';
import '../widgets/widgets.dart';
import 'account_verification.dart';
import 'lease_page.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final _topCardsElevation = 4.0, _lowCardsElevation = 6.0;
  var _iconColor = Constants().primaryColor();

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

  @override
  Widget build(BuildContext context) {
    bool _isDarkModeOn = Theme.of(context).brightness == Brightness.dark;

    if (_isDarkModeOn) {
      _iconColor = Constants().primaryColorDark();
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 14),
            Card(
              elevation: _topCardsElevation,
              child: ListTile(
                leading: Icon(
                  Icons.verified_outlined,
                  color: _iconColor,
                ),
                title: const Text('Profile Verification'),
                onTap: () => dbHasData
                    ? nextPage(context: context, page: const UserProfile())
                    : nextPage(
                        context: context, page: const VerificationPage()),
              ),
            ),
            const SizedBox(height: 14),
            Card(
              elevation: _topCardsElevation,
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.chrome,
                  color: _iconColor,
                ),
                title: const Text('Qaizen Website'),
                onTap: () => _openLink('https://www.qaizen.co.ke/'),
              ),
            ),
            const SizedBox(height: 14),
            Card(
              elevation: _topCardsElevation,
              child: ListTile(
                leading: Icon(
                  Icons.location_on_outlined,
                  color: _iconColor,
                ),
                title: const Text('Visit Office'),
                onTap: () => _openLink(
                    "https://www.google.com/maps/place/Qaizen+Car+Rentals/@-1.3084742,36.907569,17z/data=!3m1!4b1!4m5!3m4!1s0x182f13aac0a7bc05:0x431e46af05249d3e!8m2!3d-1.3084742!4d36.9097631"),
              ),
            ),
            const SizedBox(height: 14),
            Card(
              elevation: _topCardsElevation,
              child: ListTile(
                leading: Icon(
                  Icons.link_outlined,
                  color: _iconColor,
                ),
                title: const Text('Share App Link'),
                onTap: () async {
                  _onShareData(
                      context,
                      "https://play.google.com/store/apps/details?id=com.qaizencarrental.qaizen_car_rental",
                      'Qaizen Car Rental App Link');
                },
              ),
            ),
            const SizedBox(height: 14),
            Card(
              elevation: _topCardsElevation,
              child: ListTile(
                leading: Icon(
                  Icons.lock_person_outlined,
                  color: _iconColor,
                ),
                title: const Text('Privacy Policy'),
                onTap: () {
                  setState(() {
                    nextPage(context: context, page: const PrivacyPolicyPage());
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 10),
            const Center(child: Text('Extras')),
            const SizedBox(height: 10),
            Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => nextPage(
                          context: context, page: const ReferralProgramPage()),
                      child: Card(
                          elevation: _lowCardsElevation,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 140),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.people_alt_outlined,
                                    color: _iconColor,
                                    size: 64,
                                    //color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 8, right: 8, bottom: 8),
                                  child: Text('Referral Program'),
                                )
                              ],
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () =>
                          nextPage(context: context, page: const LeasePage()),
                      child: Card(
                          elevation: _lowCardsElevation,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 140),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.handshake_outlined,
                                    color: _iconColor,
                                    size: 64,
                                    //color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 8, right: 8, bottom: 8),
                                  child: Text('Lease With Us'),
                                )
                              ],
                            ),
                          )),
                    ),
                  ]),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _openLink(
                      "https://www.instagram.com/qaizencarrental/?hl=en"),
                  child: const FaIcon(
                    FontAwesomeIcons.instagram,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                    onTap: () => _openLink("https://wa.me/254797228948"),
                    child: const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.green,
                      size: 32,
                    )),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () =>
                      _openLink('https://www.facebook.com/qaizen.carrental/'),
                  child: const FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.indigo,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () => _openLink('https://twitter.com/qaizencarrental'),
                  child: const FaIcon(
                    FontAwesomeIcons.twitter,
                    color: Colors.blue,
                    size: 32,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 0)
          ],
        ),
      ),
    );
  }
}
