import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qaizen_car_rental/ui/pages/home_page.dart';
import 'package:qaizen_car_rental/ui/pages/home_screen.dart';

import '../widgets/text_form_field.dart';
import '../widgets/widgets.dart';
import 'acc_verification_page2.dart';

class AccVerificationPage4 extends StatefulWidget {
  const AccVerificationPage4({super.key});

  @override
  State<AccVerificationPage4> createState() => _AccVerificationPage4State();
}

class _AccVerificationPage4State extends State<AccVerificationPage4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            const Text(
              'Provide details of your referees.',
              style: TextStyle(fontSize: 18),
            ),
            textFormField(
              textInputType: TextInputType.name,
              context: context,
              icon: Icons.person_outline,
              labelText: 'Full name of your parent or relative: ',
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
              textInputType: TextInputType.name,
              context: context,
              icon: Icons.person_outline,
              labelText: 'Full name of your spouse or friend: ',
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
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(
                        "Form Submission Successful",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      content: const Text(
                        "Thank you for submitting the form. We have received it and will review it within the next 6 hours during the day. We will get back to you as soon as possible",
                        style: TextStyle(fontSize: 18),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
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
