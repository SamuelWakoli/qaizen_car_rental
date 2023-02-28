import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/db/user.dart';

class ReportIssuePage extends StatefulWidget {
  const ReportIssuePage({super.key});

  @override
  State<ReportIssuePage> createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  String issueText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Issue'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 810),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Please tell us what happened.',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    issueText = value;
                  },
                  minLines: 1,
                  maxLines: 8,
                  cursorHeight: 22,
                  cursorWidth: 2,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    labelText: 'Type here:',
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () async {
                    if (issueText == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please type your issue'),
                        ),
                      );
                    } else {
                      Map<String, dynamic> data = {
                        'issue': issueText,
                        'read': false
                      };
                      await FirebaseFirestore.instance
                          .collection('issues')
                          .doc("${getUserName()} ${DateTime.now()}")
                          .set(data)
                          .whenComplete(
                        () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return const AlertDialog(
                                  title: Text('Report Sent'),
                                  content: Text(
                                      'Thank you for reporting an issue to us. We will review it fix it.'),
                                );
                              });
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.send_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Send',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
