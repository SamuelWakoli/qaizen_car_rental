import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaizen_car_rental/ui/pages/hire_summary.dart';
import 'package:qaizen_car_rental/ui/pages/pick_location.dart';
import 'package:qaizen_car_rental/ui/pages/terms_conditions.dart';

import '../../db/user.dart';
import '../../shared/hire_vehicle_data.dart';
import '../widgets/widgets.dart';

class HirePage extends StatefulWidget {
  const HirePage({super.key});

  @override
  State<HirePage> createState() => _HirePageState();
}

///terms and conditions
class _HirePageState extends State<HirePage> {
  final formKey = GlobalKey<FormState>();

  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(), //prevent user from selecting old date
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        selectedDate =
            '${currentDate.day}/${currentDate.month}/${currentDate.year}';
      });
    }
  }

  TimeOfDay currentTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: currentTime);
    if (pickedTime != null) {
      setState(() {
        //prevent user from picking old time

        currentTime = pickedTime;
        selectedTime = '${pickedTime.hour}:${pickedTime.minute}';
      });
    }
  }

  String? formattedTime() {
    if (currentTime.hour < 10 && currentTime.minute < 10) {
      selectedTime = '0${currentTime.hour}:0${currentTime.minute}';
      return selectedTime;
    } else if (currentTime.hour < 10) {
      selectedTime = '0${currentTime.hour}:${currentTime.minute}';
      return selectedTime;
    } else if (currentTime.minute < 10) {
      selectedTime = '${currentTime.hour}:0${currentTime.minute}';
      return selectedTime;
    } else {
      selectedTime = '${currentTime.hour}:${currentTime.minute}';
      return selectedTime;
    }
  }

  Widget showDeliveryLocation() {
    if (delivery) {
      return ListTile(
          leading: Icon(
            Icons.location_on_outlined,
            size: 32,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            'Select delivery location:',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          subtitle: Text(
            locationAddress,
            style: const TextStyle(fontSize: 16),
          ),
          onTap: () {
            nextPage(context: context, page: const PickLocation());
          });
    } else {
      return const SizedBox();
    }
  }

  bool acceptedTerms = false;

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('vehicles')
                .doc(CurrentVehicleDocID)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                );
              }
              return Text(snapshot.data!.get('name'));
            }),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 510, minWidth: 300),
            child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Center(
                        child: Text(
                          'Provide details for the following fields:',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: Icon(FontAwesomeIcons.clock,
                            size: 32, color: Theme.of(context).primaryColor),
                        title: Text(
                          'Select time:',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        subtitle: Text(
                          formattedTime()!,
                          style: const TextStyle(fontSize: 16),
                        ),
                        onTap: () => _selectTime(context),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.calendar_month_outlined,
                          size: 32,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(
                          'Select date:',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        subtitle: Text(
                          '${currentDate.day}/${currentDate.month}/${currentDate.year}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        onTap: () => _selectDate(context),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Name cannot be empty";
                            }
                          },
                          onChanged: (value) {
                            numberOfDays = value;
                          },
                          minLines: 1,
                          cursorHeight: 22,
                          cursorWidth: 2,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelText: "Number of days:",
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor),
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
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          'Delivery',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                          'Do you want the vehicle to be delivered to you? (Delivery fee applied)'),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: RadioListTile(
                              title: const Text("Yes"),
                              value: true,
                              groupValue: delivery,
                              onChanged: (value) {
                                setState(() {
                                  delivery = value!;
                                });
                              },
                              activeColor: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: RadioListTile(
                              title: const Text("No"),
                              value: false,
                              groupValue: delivery,
                              onChanged: (value) {
                                setState(() {
                                  delivery = value!;
                                });
                              },
                              activeColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      showDeliveryLocation(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: acceptedTerms,
                            onChanged: ((value) {
                              setState(() {
                                acceptedTerms = value!;
                              });
                            }),
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Theme.of(context).primaryColor),
                          ),
                          Text.rich(TextSpan(
                            text: "I accept the ",
                            style: const TextStyle(fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "terms and conditions",
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
                                          page: const TermsConditionsPage());
                                    }),
                            ],
                          )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () async {
                            String messageText = '';
                            if (acceptedTerms == false) {
                              messageText =
                                  'Accept the terms and conditions to continue.';
                            } else {
                              messageText = 'Please enter number of days.';
                            }
                            acceptedTerms && numberOfDays != ''
                                ? {
                                    selectedVehicles?.clear(),
                                    selectedVehicles?.add(CurrentVehicleDocID),
                                    totalCost = 0,
                                    totalCost = await getCost(),
                                    nextPage(
                                        context: context,
                                        page: const HireSummary())
                                  }
                                : showSnackbar(
                                    context: context,
                                    duration: 4,
                                    message: messageText);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ///use this location in the driver app
                                  'Next',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
