import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/pages/account_verification.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';

import '../../db/user.dart';
import '../widgets/text_form_field.dart';

class ReferralProgramPage extends StatefulWidget {
  const ReferralProgramPage({Key? key}) : super(key: key);

  @override
  State<ReferralProgramPage> createState() => _ReferralProgramPageState();
}

class _ReferralProgramPageState extends State<ReferralProgramPage> {
  bool loading = false;

  List<Widget> guidelines = [
    const Text(
      """
1. Referral program is open to all verified users of the app.
2. Each user will be provided with a unique referral code, which can be shared with friends and family.
3. For each successful referral, the referrer will receive a reward (e.g. discounts, etc.).
4. The referred user must enter the referral code after installing this app and complete a rental service for the referral to be considered successful.
5. There is a maximum limit on the number of referrals that a user can make, for example 5 referrals per month.
6. The referral rewards have an expiration date, for example, rewards will expire after 30 days of being credited to the user's account.
7. The referral program can be modified or terminated at any time without notice.
8. Any attempt to abuse the referral program, including but not limited to creating fake accounts, will result in disqualification from the program and potential suspension or termination of the user's account.
9. The referral program is void where prohibited by law.
10. By participating in the referral program, users agree to these guidelines and the decisions of the company, which are final and binding in all matters related to the referral program.
""",
      style: TextStyle(fontSize: 16),
    ),
    const SizedBox(),
    const Icon(Icons.arrow_drop_down, size: 32),
    const Icon(Icons.arrow_drop_up, size: 32),
    const Text("Show program guidelines"),
    const Text("Hide program guidelines"),
    const Text("Enter referral code from a friend"),
  ];

  int currentButtonText = 4;
  int currentButtonIcon = 2;
  int currentListItem = 1;

  void _textClicked() {
    if (currentButtonText == 4 &&
        currentButtonIcon == 2 &&
        currentListItem == 1) {
      currentButtonText = 5;
      currentButtonIcon = 3;
      currentListItem = 0;
    } else {
      currentButtonText = 4;
      currentButtonIcon = 2;
      currentListItem = 1;
    }
  }

  String getCode() {
    String code = "";
    fireStoreUserData.get().then((value) {
      final data = value.data() as Map<String, dynamic>;
      code = data["referral code"].toString();
    });
    return code;
  }

  Widget _body() {
    if (currentButtonText == 4) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Your referral code is:',
            style: TextStyle(fontSize: 16),
          ),
          StreamBuilder(
              stream: fireStoreUserData.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  );
                }

                //so as to allow [containsKey()]
                Map<String, dynamic> dataMap =
                    snapshot.data!.data() as Map<String, dynamic>;
                if (snapshot.hasData && dataMap.containsKey('referral code')) {
                  return Text(
                    snapshot.data!['referral code'].toString(),
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).primaryColor),
                  );
                } else {
                  return TextButton(
                    onPressed: () {
                      nextPage(
                          context: context, page: const VerificationPage());
                    },
                    child:
                        const Text('Verify your account to get referral code'),
                  );
                }
              }),
          const SizedBox(height: 20),
          const Text(
            'Refer a friend to our car rental app and get a reward on your next rental. Simply share your unique referral code with a friend and have them enter it at the time of their first rental. Once they complete their rental, you will receive your discount notification. Start referring now and save on your next rental!',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          MaterialButton(
            onPressed: () => setState(() => _textClickedRef()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                guidelines[currentBtnTxtRef],
                const SizedBox(width: 20),
                guidelines[currentButtonIconRef]
              ],
            ),
          ),
          _referralBody(),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  int currentBtnTxtRef = 6;
  int currentButtonIconRef = 2;
  int currentListItemRef = 1;

  void _textClickedRef() {
    if (currentButtonIconRef == 2 && currentListItem == 1) {
      currentButtonIconRef = 3;
      currentListItemRef = 0;
    } else {
      currentButtonIconRef = 2;
      currentListItemRef = 1;
    }
  }

  String friendName = '', friendPhone = '', friendCode = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _referralBody() {
    List<Widget> referralBody = [
      Form(
        key: _formKey,
        child: Column(
          children: [
            textFormField(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.name,
              context: context,
              icon: Icons.person_outline,
              labelText: 'Friend\'s name: ',
              hintText: '',
              onChanged: (val) {
                setState(() => friendName = val);
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
              labelText: 'Friend\'s phone number: ',
              hintText: '',
              onChanged: (val) {
                setState(() => friendPhone = val);
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
              textInputAction: null,
              textInputType: TextInputType.text,
              context: context,
              icon: Icons.numbers,
              labelText: 'Friend\'s referral code: ',
              hintText: '',
              onChanged: (val) {
                setState(() => friendCode = val);
              },
              validator: (val) {
                if (val!.isNotEmpty) {
                  return null;
                } else {
                  return "Referral code cannot be empty";
                }
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });

                    Map<String, dynamic> data = {
                      'client doc id': userID,
                      "time":
                          "${DateTime.now().hour}H:${DateTime.now().minute}M:${DateTime.now().second}S  Day: ${DateTime.now().day} Month: ${DateTime.now().month}",
                      "friend": friendName,
                      "phone": friendPhone,
                      "code": friendCode,
                      "approved": false,
                    };

                    await FirebaseFirestore.instance
                        .collection('referrals')
                        .doc("${DateTime.now()}")
                        .set(data)
                        .whenComplete(() {
                      setState(() {
                        loading = false;
                      });
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(
                            "Submission Successful",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          content: const Text(
                            "We are checking the referral code you entered. Please wait while we confirm its validity. You will get a notification after validation.",
                            style: TextStyle(fontSize: 18),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context)
                                  .popUntil((route) => route.isFirst),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.home_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    'Go to Home Screen',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  }
                },
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ))
                    : Row(
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
          ],
        ),
      ),
      const SizedBox(),
    ];
    if (currentListItemRef == 0) {
      return referralBody[currentListItemRef];
    } else {
      return referralBody[currentListItemRef];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Referral Program'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              MaterialButton(
                onPressed: () => setState(() => _textClicked()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    guidelines[currentButtonText],
                    const SizedBox(width: 20),
                    guidelines[currentButtonIcon]
                  ],
                ),
              ),
              guidelines[currentListItem],
              _body(),
            ],
          ),
        ),
      ),
    );
  }
}
