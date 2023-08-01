import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qaizen_car_rental/ui/pages/home_screen.dart';

import '../../helper/communication.dart';

/// This is the SignIn Screen created using tha packages: firebase_ui_auth: ^1.1.9
/// and firebase_ui_oauth_google: ^1.0.16
/// The auth providers have been configured in the [main.dart] file.
class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SignInScreen(
              headerBuilder: (context, constraints, _) {
                return Padding(
                  padding: const EdgeInsets.only(top: 68.0),
                  child: Image.asset("assets/qaizenlogo.png"),
                );
              },
              footerBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text.rich(
                    TextSpan(text: 'Need help? ', children: [
                      TextSpan(
                          text: 'Call Us',
                          style: const TextStyle(
                            //color: Theme.of(context).primaryColor,
                            color: Colors.deepPurple,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        icon: const Icon(
                                          Icons.phone_outlined,
                                          color: Colors.blue,
                                        ),
                                        title: const Text("Call Us"),
                                        content: const Text(
                                          "We're here to help with any questions or concerns you may have. Do you want to proceed with the call?",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.of(ctx).pop();
                                              //call
                                              //when call permission is granted:
                                              await FlutterPhoneDirectCaller
                                                  .callNumber('+254726371714');
                                              //else not granted, just show phone number
                                              if (await Permission
                                                  .phone.isDenied) {
                                                makePhoneCall();
                                              }
                                            },
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(ctx).pop(),
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ),
                                        ],
                                      ));
                            })
                    ]),
                  ),
                );
              },
            ),
          );
        }

        return const HomeScreen();
      },
    );
  }
}
