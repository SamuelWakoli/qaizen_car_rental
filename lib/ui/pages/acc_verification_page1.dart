import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/text_form_field.dart';
import '../widgets/widgets.dart';
import 'acc_verification_page1b.dart';

class AccVerificationPage1 extends StatefulWidget {
  const AccVerificationPage1({super.key});

  @override
  State<AccVerificationPage1> createState() => _AccVerificationPage1State();
}

class _AccVerificationPage1State extends State<AccVerificationPage1> {
  String? socMedAccType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            const Text(
              'Complete this form by filling all the following fields:',
              style: TextStyle(fontSize: 18),
            ),
            textFormField(
              textInputType: TextInputType.name,
              context: context,
              icon: Icons.person_outline,
              labelText: 'Full name: ',
              hintText: '',
              onChanged: (val) {
                setState(() {
                  //fullName = val;
                });
              },
              validator: (val) {
                // if (val!.isNotEmpty) {
                //   return null;
                // } else {
                //   return "Name cannot be empty";
                // }
              },
            ),
            textFormField(
              textInputType: TextInputType.phone,
              context: context,
              icon: Icons.phone_outlined,
              labelText: 'Phone number: ',
              hintText: '',
              onChanged: (val) {
                setState(() {
                  //fullName = val;
                });
              },
              validator: (val) {
                // if (val!.isNotEmpty) {
                //   return null;
                // } else {
                //   return "Name cannot be empty";
                // }
              },
            ),
            textFormField(
              textInputType: TextInputType.number,
              context: context,
              icon: Icons.man_outlined,
              labelText: 'Age: ',
              hintText: '',
              onChanged: (val) {
                setState(() {
                  //fullName = val;
                });
              },
              validator: (val) {
                // if (val!.isNotEmpty) {
                //   return null;
                // } else {
                //   return "Name cannot be empty";
                // }
              },
            ),
            textFormField(
              textInputType: TextInputType.number,
              context: context,
              icon: Icons.drive_eta_outlined,
              labelText: 'Driving experience: ',
              hintText: '(Years)',
              onChanged: (val) {
                setState(() {
                  //fullName = val;
                });
              },
              validator: (val) {
                // if (val!.isNotEmpty) {
                //   return null;
                // } else {
                //   return "Name cannot be empty";
                // }
              },
            ),
            textFormField(
              textInputType: TextInputType.text,
              context: context,
              icon: Icons.location_city_rounded,
              labelText: 'Occupation: ',
              hintText: '',
              onChanged: (val) {
                setState(() {
                  //fullName = val;
                });
              },
              validator: (val) {
                // if (val!.isNotEmpty) {
                //   return null;
                // } else {
                //   return "Name cannot be empty";
                // }
              },
            ),
            textFormField(
              textInputType: TextInputType.name,
              context: context,
              icon: Icons.home_work_outlined,
              labelText: 'Residence: ',
              hintText: '',
              onChanged: (val) {
                setState(() {
                  //fullName = val;
                });
              },
              validator: (val) {
                // if (val!.isNotEmpty) {
                //   return null;
                // } else {
                //   return "Name cannot be empty";
                // }
              },
            ),
            const SizedBox(height: 10),
            const Text(
              'Social media presence:',
              style: TextStyle(fontSize: 18),
            ),
            Column(
              children: [
                RadioListTile(
                  title: Row(children: const [
                    Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.indigo,
                    ),
                    SizedBox(width: 10),
                    Text("Facebook"),
                  ]),
                  value: "Facebook",
                  groupValue: socMedAccType,
                  onChanged: (value) {
                    setState(() {
                      socMedAccType = value;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
                RadioListTile(
                  title: Row(children: const [
                    Icon(
                      FontAwesomeIcons.instagram,
                    ),
                    SizedBox(width: 10),
                    Text("Instagram"),
                  ]),
                  value: "Instagram",
                  groupValue: socMedAccType,
                  onChanged: (value) {
                    setState(() {
                      socMedAccType = value;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
                RadioListTile(
                  title: Row(children: const [
                    Icon(
                      FontAwesomeIcons.twitter,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10),
                    Text("Twitter"),
                  ]),
                  value: "Twitter",
                  groupValue: socMedAccType,
                  onChanged: (value) {
                    setState(() {
                      socMedAccType = value;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
            textFormField(
              textInputType: TextInputType.name,
              context: context,
              icon: Icons.account_box_rounded,
              labelText: 'Social media username: ',
              hintText: '',
              onChanged: (val) {
                setState(() {
                  //fullName = val;
                });
              },
              validator: (val) {
                // if (val!.isNotEmpty) {
                //   return null;
                // } else {
                //   return "Name cannot be empty";
                // }
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () => nextPage(
                    context: context, page: const AccVerificationPage1b()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Next',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor)),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.arrow_forward,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}
