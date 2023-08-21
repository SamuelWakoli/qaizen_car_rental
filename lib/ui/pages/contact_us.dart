import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../helper/communication.dart';
import '../widgets/widgets.dart';
import 'report_issue.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  double titleFontSize = 20.0, subTitleFontSize = 18.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Contact Us"),
        ),
        body: Card(
          child: Center(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 0,
                          child: Column(
                            children: [
                              const ListTile(
                                title: Text(
                                  "Real-time assistance",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Divider(),
                              ),
                              ListTile(
                                onTap: () {
                                  makePhoneCall();
                                },
                                leading: const Icon(
                                  Icons.phone_outlined,
                                  color: Colors.blue,
                                ),
                                title: Text(
                                  "Phone Call",
                                  style: TextStyle(fontSize: titleFontSize),
                                ),
                                subtitle: Text(
                                  "+254726371714",
                                  style: TextStyle(
                                    fontSize: subTitleFontSize,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Divider(),
                              ),
                              ListTile(
                                onTap: () {
                                  openWhatsApp();
                                },
                                leading: const Icon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.green,
                                ),
                                title: Text(
                                  "WhatsApp",
                                  style: TextStyle(fontSize: titleFontSize),
                                ),
                                subtitle: Text(
                                  "https://wa.me/254726371714",
                                  style: TextStyle(
                                    fontSize: subTitleFontSize,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 0,
                          child: Column(
                            children: [
                              const ListTile(
                                title: Text(
                                  "Other",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Divider(),
                              ),
                              ListTile(
                                onTap: () {
                                  sendEmail();
                                },
                                leading: Icon(
                                  Icons.mail_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: Text(
                                  "Send Email",
                                  style: TextStyle(fontSize: titleFontSize),
                                ),
                                subtitle: Text(
                                  "info@qaizen.co.ke",
                                  style: TextStyle(
                                    fontSize: subTitleFontSize,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Divider(),
                              ),
                              ListTile(
                                onTap: () {
                                  nextPage(
                                      context: context,
                                      page: const ReportIssuePage());
                                },
                                leading: Icon(
                                  Icons.help_outline,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: Text(
                                  "Report issue",
                                  style: TextStyle(fontSize: titleFontSize),
                                ),
                                subtitle: Text(
                                  "In-app",
                                  style: TextStyle(fontSize: subTitleFontSize),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))),
        ));
  }
}
