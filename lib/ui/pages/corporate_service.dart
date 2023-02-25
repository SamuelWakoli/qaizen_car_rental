import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaizen_car_rental/ui/pages/pick_location.dart';
import 'package:qaizen_car_rental/ui/pages/select_driver.dart';
import 'package:qaizen_car_rental/ui/pages/select_vehicle_cat.dart';

import '../../shared/hire_vehicle_data.dart';
import '../widgets/widgets.dart';
import 'corporate_summary.dart';

class CorporateServicePage extends StatefulWidget {
  const CorporateServicePage({super.key});

  @override
  State<CorporateServicePage> createState() => _CorporateServicePageState();
}

class _CorporateServicePageState extends State<CorporateServicePage> {
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

  String? formatedTime() {
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Corporate Service'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    return null;
                  } else {
                    return "Organisation's name cannot be empty";
                  }
                },
                onChanged: (value) {
                  orgName = value;
                },
                minLines: 1,
                cursorHeight: 22,
                cursorWidth: 2,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  labelText: "Organisation's Name:",
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
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
                keyboardType: TextInputType.name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    return null;
                  } else {
                    return "Number of days cannot be empty";
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
            ListTile(
              leading: Icon(FontAwesomeIcons.clock,
                  size: 32, color: Theme.of(context).primaryColor),
              title: Text(
                'Select time',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              subtitle: Text(
                formatedTime()!,
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
                'Select date',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    serviceType = 'Corporate';
                    driversNames?.clear();
                    selectedVehicleNames?.clear();
                    selectedVehicles?.clear();
                    nextPage(context: context, page: const SelectVehicleCat());
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        driverNeeded
                            ? 'Select vehicle(s) and driver(s)'
                            : 'Select vehicle(s)',
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
    );
  }
}
