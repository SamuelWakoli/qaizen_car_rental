import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaizen_car_rental/ui/pages/select_vehicle_cat.dart';

import '../../shared/hire_vehicle_data.dart';
import '../widgets/widgets.dart';

class ChauffeuredPage extends StatefulWidget {
  const ChauffeuredPage({super.key});

  @override
  State<ChauffeuredPage> createState() => _ChauffeuredPageState();
}

class _ChauffeuredPageState extends State<ChauffeuredPage> {
//
// start date time
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(), //prevent user from selecting old date
        lastDate: DateTime(2026));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chauffeured Service'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Provide details for the following fields:',
            style: TextStyle(fontSize: 18),
          ),
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
                if (numberOfDays != '') {
                  selectedVehicles?.clear();
                  selectedVehicleNames?.clear();
                  setState(() {});
                  serviceType = "Chauffeured";
                  nextPage(context: context, page: const SelectVehicleCat());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please enter number of days.')));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ///use this location in the driver app
                      'Select Vehicle',
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
