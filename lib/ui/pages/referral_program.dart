import 'package:flutter/material.dart';

class ReferralProgramPage extends StatefulWidget {
  const ReferralProgramPage({Key? key}) : super(key: key);

  @override
  State<ReferralProgramPage> createState() => _ReferralProgramPageState();
}

class _ReferralProgramPageState extends State<ReferralProgramPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Referral Program'),
          centerTitle: true,
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 810),
          child: Center(
            child: Column(
              children: [
                Text('Referral Program'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
