import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

import '../../db/user.dart';
import '../widgets/text_form_field.dart';

class AccVerificationPage4 extends StatefulWidget {
  const AccVerificationPage4({super.key});

  @override
  State<AccVerificationPage4> createState() => _AccVerificationPage4State();
}

class _AccVerificationPage4State extends State<AccVerificationPage4> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? refName1 = '';
  String? refPhone1 = '';
  String? refName2 = '';
  String? refPhone2 = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [Text('Page 5 out of 5')],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            const Text(
              'Provide details of your referees.',
              style: TextStyle(fontSize: 18),
            ),
            textFormField(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.name,
              context: context,
              icon: Icons.person_outline,
              labelText: 'Full name of your parent or relative: ',
              hintText: '',
              onChanged: (val) {
                setState(() {
                  refName1 = val;
                });
              },
              validator: (val) {
                if (val!.isNotEmpty) {
                  return null;
                } else {
                  return "Name cannot be empty";
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
                setState(() {
                  refPhone1 = val;
                });
              },
              validator: (val) {
                if (val!.isNotEmpty) {
                  return null;
                } else {
                  return "Phone number cannot be empty";
                }
              },
            ),
            textFormField(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.name,
              context: context,
              icon: Icons.person_outline,
              labelText: 'Full name of your spouse or friend: ',
              hintText: '',
              onChanged: (val) {
                setState(() {
                  refName2 = val;
                });
              },
              validator: (val) {
                if (val!.isNotEmpty) {
                  return null;
                } else {
                  return "Name cannot be empty";
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
                setState(() {
                  refPhone2 = val;
                });
              },
              validator: (val) {
                if (val!.isNotEmpty) {
                  return null;
                } else {
                  return "Phone number cannot be empty";
                }
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snack-bar. In the real world,
                    // you'd often call a server or save the information in a database.

                    setState(() {
                      loading = true;
                    });

                    final refData = <String, dynamic>{
                      "referee name 1": refName1,
                      "referee phone 1": refPhone1,
                      "referee name 2": refName2,
                      "referee phone 2": refPhone2,
                      "verified": false
                    };

                    await UserData.update(refData).whenComplete(() {
                      return CurrentUser!
                          .sendEmailVerification()
                          .whenComplete(() {
                        setState(() {
                          loading = false;
                        });

                        return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(
                              "Form Submission Successful",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            content: const Text(
                              "Thank you for submitting this form. We have received it and will review it within the next 6 hours during the day. To complete the process, please also check your email inbox to verify your email address. We will get back to you as soon as possible.",
                              style: TextStyle(fontSize: 18),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                  //Restart.restartApp();
                                  setState(() {
                                    dbHasData = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          ' You can now access our services through this app while awaiting for verification'),
                                      duration: Duration(seconds: 5),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  child: Text(
                                    "okay",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Submit',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor)),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.check,
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
