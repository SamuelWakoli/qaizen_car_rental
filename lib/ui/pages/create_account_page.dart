import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/material_button.dart';
import '../widgets/text_form_field.dart';
import '../widgets/widgets.dart';
import '../pages/home_screen.dart';
import 'sign_in_page.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  //AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor))
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                  child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("assets/qaizenlogo.png"),
                          const SizedBox(height: 10),
                          Text.rich(TextSpan(
                            text: "Already have an account? ",
                            style: const TextStyle(fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Sign in",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      nextPage(
                                          context: context,
                                          page: const SignInPage());
                                    }),
                            ],
                          )),
                          const SizedBox(height: 24),
                          materialButton(
                            context: context,
                            icon: FontAwesomeIcons.google,
                            text: 'Create account with Google',
                            onPressed: () {},
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          const SizedBox(height: 10),
                          const Text('Create account with email: '),
                          textFormField(
                            textInputType: TextInputType.name,
                            context: context,
                            icon: Icons.person_outline_outlined,
                            labelText: "Full Name: ",
                            hintText: "",
                            onChanged: (val) {
                              setState(() {
                                fullName = val;
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
                            textInputType: TextInputType.emailAddress,
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
                            textInputType: TextInputType.visiblePassword,
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
                                () {
                              nextPageReplace(
                                  context: context, page: const HomeScreen());
                            },
                          ),
                        ],
                      )),
                ),
              ),
            ),
    );
  }

  // register() async {
  //   if (formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     await authService
  //         .registerUserWithEmailandPassword(fullName, email, password)
  //         .then((value) async {
  //       if (value == true) {
  //         // saving the shared preference state
  //         await HelperFunctions.saveUserLoggedInStatus(true);
  //         await HelperFunctions.saveUserEmailSF(email);
  //         await HelperFunctions.saveUserNameSF(fullName);
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
