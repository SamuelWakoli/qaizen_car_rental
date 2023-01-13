import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaizen_car_rental/ui/pages/pick_location.dart';
import 'package:qaizen_car_rental/ui/pages/select_driver.dart';
import 'package:qaizen_car_rental/ui/pages/select_vehicle_cat.dart';
import 'package:qaizen_car_rental/ui/pages/terms_conditions.dart';
import 'package:qaizen_car_rental/ui/pages/weddings_events_summary.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/hire_vehicle_data.dart';
import '../widgets/widgets.dart';

class WeddingsEventsPage extends StatefulWidget {
  const WeddingsEventsPage({super.key});

  @override
  State<WeddingsEventsPage> createState() => _WeddingsEventsPageState();
}

class _WeddingsEventsPageState extends State<WeddingsEventsPage> {
  //
// start date time
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

  String formatedTime() {
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

// end date time
//
  bool driverNeeded = false;

  Widget needDriver() {
    if (driverNeeded) {
      return ListTile(
        onTap: () {
          nextPage(context: context, page: const SelectDriver());
        },
        leading: Icon(
          Icons.person_outline,
          color: Theme.of(context).primaryColor,
          size: 32,
        ),
        title: Text(
          'Select driver(s)',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        subtitle: const Text(
          '\$driversNames',
          style: TextStyle(fontSize: 16),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  bool acceptedTerms = false;

  Future<void> _openLink(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // can't launch url
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weddings & Events'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                _openLink("https://www.instagram.com/qaizencarrental/?hl=en"),
            icon: const FaIcon(
              FontAwesomeIcons.instagram,
            ),
            tooltip: 'Instagram',
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Provide details for the following fields:',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            onTap: () {
              nextPage(context: context, page: const PickLocation());
            },
            leading: Icon(
              Icons.location_on_outlined,
              color: Theme.of(context).primaryColor,
              size: 32,
            ),
            title: Text(
              'Select location:',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: Text(
              locationAddress,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          ListTile(
            onTap: () {
              nextPage(context: context, page: const SelectVehicleCat());
            },
            leading: Icon(
              Icons.car_rental_outlined,
              color: Theme.of(context).primaryColor,
              size: 32,
            ),
            title: Text(
              'Select vehicle(s):',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: const Text(
              '\$selecedVehicles',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('Do you need our driver(s)?'),
          ),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: RadioListTile(
                  title: const Text("Yes"),
                  value: true,
                  groupValue: driverNeeded,
                  onChanged: (value) {
                    setState(() {
                      driverNeeded = value!;
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
                  groupValue: driverNeeded,
                  onChanged: (value) {
                    setState(() {
                      driverNeeded = value!;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          needDriver(),
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
              formatedTime(),
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
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
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
            child: MaterialButton(
              onPressed: () {
                acceptedTerms
                    ? nextPage(
                        context: context, page: const WeddingsEventsSummary())
                    : showSnackbar(
                        context: context,
                        duration: 4,
                        message:
                            'Accept the terms and conditions to continue.');
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
      )),
    );
  }
}