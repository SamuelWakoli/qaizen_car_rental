import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaizen_car_rental/ui/pages/account_verification.dart';
import 'package:qaizen_car_rental/ui/pages/manage_favorites.dart';
import 'package:qaizen_car_rental/ui/pages/privacy_policy.dart';
import 'package:qaizen_car_rental/ui/pages/referral_program.dart';

import '../../shared/constants.dart';
import '../widgets/widgets.dart';
import 'lease_page.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final _topCardsElevation = 4.0, _lowCardsElevation = 6.0;
  var _iconColor = Constants().primaryColor();

  @override
  Widget build(BuildContext context) {
    bool _isDarkModeOn = Theme.of(context).brightness == Brightness.dark;

    if (_isDarkModeOn) {
      _iconColor = Constants().primaryColorDark();
    }

    return ListView(
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 810),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Card(
                    elevation: _topCardsElevation,
                    child: ListTile(
                      leading: Icon(
                        Icons.verified_outlined,
                        color: _iconColor,
                      ),
                      title: const Text('Account Verification'),
                      onTap: () {
                        setState(() {
                          nextPage(context: context, page: const VerificationPage());
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: _topCardsElevation,
                    child: ListTile(
                      leading: Icon(
                        Icons.favorite_outline_outlined,
                        color: _iconColor,
                      ),
                      title: const Text('Manage Favorites'),
                      onTap: () {
                        setState(() {
                          nextPage(context: context, page: const ManageFavoritesPage());
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: _topCardsElevation,
                    child: ListTile(
                      leading: Icon(
                        Icons.cloud_outlined,
                        color: _iconColor,
                      ),
                      title: const Text('Qaizen Website'),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: _topCardsElevation,
                    child: ListTile(
                      leading: Icon(
                        Icons.location_city_outlined,
                        color: _iconColor,
                      ),
                      title: const Text('Visit Office'),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: _topCardsElevation,
                    child: ListTile(
                      leading: Icon(
                        Icons.link_outlined,
                        color: _iconColor,
                      ),
                      title: const Text('Share App Link'),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 14),
                  const Center(child: Text('Extras')),
                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                nextPage(context: context, page: const ReferralProgramPage()),
                            child: Card(
                                elevation: _lowCardsElevation,
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(minWidth: 140),
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
                            onTap: () => nextPage(context: context, page: const LeasePage()),
                            child: Card(
                                elevation: _lowCardsElevation,
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(minWidth: 140),
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
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(
                        FontAwesomeIcons.instagram,
                      ),
                      SizedBox(width: 30),
                      FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                      SizedBox(width: 30),
                      FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.indigo,
                      ),
                      SizedBox(width: 30),
                      FaIcon(
                        FontAwesomeIcons.twitter,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
