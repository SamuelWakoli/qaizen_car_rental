import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../db/user.dart';
import '../widgets/text_form_field.dart';
import '../widgets/widgets.dart';
import 'acc_verification_page1b.dart';

class AccVerificationPage1 extends StatefulWidget {
  const AccVerificationPage1({super.key});

  @override
  State<AccVerificationPage1> createState() => _AccVerificationPage1State();
}

class _AccVerificationPage1State extends State<AccVerificationPage1> {
  String? fullName = '';
  String? phoneNumber = '';
  String? age = '';
  String? drivingExperience = '';
  String? occupation = '';
  String? residence = '';
  String? socMedAccType = '';
  String? socMedAccName = '';

  String generateRandomString(int lengthOfString) {
    final random = Random();
    const allChars =
        'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(lengthOfString,
        (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString; // return the generated string
  }

  bool loading = false;

  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [Text('Page 1 out of 5')],
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Complete this form by filling all the following fields:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            textFormField(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.name,
              context: context,
              icon: Icons.person_outline,
              labelText: 'Full name: ',
              hintText: '',
              onChanged: (val) {
                fullName = val;
              },
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your full name';
                }
              },
            ),
            textFormField(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.phone,
              context: context,
              icon: Icons.phone_outlined,
              labelText: 'Phone number: ',
              hintText: '',
              onChanged: (val) {
                phoneNumber = val;
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Enter your phone number';
                }
              },
            ),
            textFormField(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
              context: context,
              icon: Icons.man_outlined,
              labelText: 'Age: ',
              hintText: '',
              onChanged: (val) {
                age = val;
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Enter your age';
                } else if (val.toString().length > 2) {
                  return 'Invalid age';
                }
              },
            ),
            textFormField(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
              context: context,
              icon: Icons.drive_eta_outlined,
              labelText: 'Driving experience: ',
              hintText: '(Years)',
              onChanged: (val) {
                drivingExperience = val;
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter years of your driving experience';
                }
              },
            ),
            textFormField(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.text,
              context: context,
              icon: Icons.cases_outlined,
              labelText: 'Occupation: ',
              hintText: '',
              onChanged: (val) {
                occupation = val;
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Enter your occupation';
                }
              },
            ),
            textFormField(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.name,
              context: context,
              icon: Icons.home_work_outlined,
              labelText: 'Residence: ',
              hintText: '',
              onChanged: (val) {
                residence = val;
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Enter your residence';
                }
              },
            ),
            const SizedBox(height: 10),
            textFormField(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.name,
              context: context,
              icon: Icons.account_box_rounded,
              labelText: 'Social media username: ',
              hintText: '',
              onChanged: (val) {
                socMedAccName = val;
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Enter your social media account name';
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Social media account type:',
                style: TextStyle(fontSize: 18),
              ),
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
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snack bar. In the real world,
                    // you'd often call a server or save the information in a database.

                    if (phoneNumber!.startsWith("0")) {
                      phoneNumber = "+254${phoneNumber!.substring(1)}";
                    }

                    setState(() {
                      loading = true;
                    });

                    final userData = <String, dynamic>{
                      "name": fullName,
                      "phone": phoneNumber,
                      "age": age,
                      "driving experience": drivingExperience,
                      "occupation": occupation,
                      "residence": residence,
                      "social media username": socMedAccName,
                      "social media type": socMedAccType,
                      "referral code": generateRandomString(10),
                      "favorites": [],
                      "verified by": "",
                      "notifications": true,
                      "passport URL": "",
                      "national ID URL": "",
                      "driving licence URL": "",
                      "referee name 1": "",
                      "referee phone 1": "",
                      "referee name 2": "",
                      "referee phone 2": "",
                      "awaiting verification": null,
                    };

                    await UserData.set(userData).whenComplete(() {
                      setState(() {
                        loading = false;
                      });
                      return nextPage(
                        context: context, page: const AccVerificationPage1b());
                    });
                  }
                },
                child: loading ? CircularProgressIndicator(color: Theme.of(context).primaryColor,) : Row(
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
