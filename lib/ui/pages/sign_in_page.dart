import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaizen_car_rental/ui/pages/create_account_page.dart';

import '../widgets/outlined_button.dart';
import '../widgets/text_form_field.dart';
import '../widgets/widgets.dart';
import '../pages/home_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;
  //AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            )
          : SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400, minWidth: 300),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 80),
                    child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/qaizenlogo.png"),
                            const SizedBox(height: 10),
                            Text.rich(TextSpan(
                              text: "Don't have an account? ",
                              style: const TextStyle(fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Create account here",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        nextPage(context: context, page: const CreateAccountPage());
                                      }),
                              ],
                            )),
                            const SizedBox(height: 24),
                            outlinedButton(
                              context: context,
                              icon: FontAwesomeIcons.google,
                              text: 'Sign in with Google',
                              onPressed: () {},
                            ),
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 10),
                            const Text('Sign in with email: '),
                            textFormField(
                              context: context,
                              icon: Icons.email_outlined,
                              labelText: "Email: ",
                              hintText: "",
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val!)
                                    ? null
                                    : "Please enter a valid email";
                              },
                            ),
                            textFormField(
                              context: context,
                              icon: Icons.lock_outline_rounded,
                              labelText: "Password: ",
                              hintText: "",
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                              validator: (val) {
                                if (val!.isNotEmpty) {
                                  return null;
                                } else {
                                  return "Password cannot be empty";
                                }
                              },
                            ),
                            normalWiderButton(
                              context: context,
                              text: "Create account",
                              onPressed:
                                  //login()
                                  () => nextPageReplace(context: context, page: const HomeScreen()),
                            ),
                          ],
                        )),
                  ),
                ),
            ),
          ),
    );
  }

  // login() async {
  //   if (formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     await authService
  //         .loginWithUserNameandPassword(email, password)
  //         .then((value) async {
  //       if (value == true) {
  //         QuerySnapshot snapshot =
  //             await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
  //                 .gettingUserData(email);
  //         // saving the values to our shared preferences
  //         await HelperFunctions.saveUserLoggedInStatus(true);
  //         await HelperFunctions.saveUserEmailSF(email);
  //         await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
  //         nextScreenReplace(context, const HomePage());
  //       } else {
  //         showSnackbar(context, Colors.red, value);
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       }
  //     });
  //   }
  // }
}
