import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaizen_car_rental/ui/pages/pick_location.dart';
import 'package:qaizen_car_rental/ui/pages/select_vehicle_cat.dart';

import '../../shared/hire_vehicle_data.dart';
import '../widgets/widgets.dart';

class ToursSafarisPage extends StatefulWidget {
  const ToursSafarisPage({super.key});

  @override
  State<ToursSafarisPage> createState() => _ToursSafarisPageState();
}

class _ToursSafarisPageState extends State<ToursSafarisPage> {
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

// end date time
//

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tours & Safaris'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
        children: [
            const SizedBox(height: 10),
            const Text(
              'Provide details for the following fields:',
              style: TextStyle(fontSize: 18),
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
                'Select Destination',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              subtitle: Text(
                deliveryAddress,
                style: const TextStyle(fontSize: 16),
              ),
            ),
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
            const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  serviceType = 'ToursSafaris';
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
                      'Select vehicle(s) and driver(s)',
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
