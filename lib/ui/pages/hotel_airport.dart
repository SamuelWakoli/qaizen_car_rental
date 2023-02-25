import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaizen_car_rental/ui/pages/pick_location.dart';

import '../../shared/hire_vehicle_data.dart';
import '../widgets/widgets.dart';
import 'hotel_airport_summary.dart';

class HotelAirportPage extends StatefulWidget {
  const HotelAirportPage({super.key});

  @override
  State<HotelAirportPage> createState() => _HotelAirportPageState();
}

class _HotelAirportPageState extends State<HotelAirportPage> {
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
//

  bool hotelORairport = false; //false for hotel

  ///Todo
  ///if service is hotel, show location list tile
  Widget showLocation() {
    if (hotelORairport == false) {
      return ListTile(
        leading: Icon(
          Icons.location_on_outlined,
          size: 32,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          'Select Hotel Location:',
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
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget showServiceName() {
    String serviceText = "";
    if (hotelORairport == false) {
      serviceText = 'Hotel Name:';
    } else {
      serviceText = 'Name of the airport:';
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        validator: (val) {
          if (val!.isNotEmpty) {
            return null;
          } else {
            return "Name cannot be empty";
          }
        },
        onChanged: (value) {
          hotelAirportName = value;
        },
        keyboardType: TextInputType.name,
        minLines: 1,
        cursorHeight: 22,
        cursorWidth: 2,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          labelText: serviceText,
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
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel & Airport Transfer'),
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
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Specify Service:',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Column(
              children: [
                RadioListTile(
                  title: const Text("Hotel Transfer"),
                  value: false,
                  groupValue: hotelORairport,
                  onChanged: (value) {
                    setState(() {
                      hotelORairport = value!;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
                RadioListTile(
                  title: const Text("Airport Transfer"),
                  value: true,
                  groupValue: hotelORairport,
                  onChanged: (value) {
                    setState(() {
                      hotelORairport = value!;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 10),
            showServiceName(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) => transferDescription = value,
                textInputAction: TextInputAction.next,
                validator: (val) {
                  if (val!.isNotEmpty) {
                    return null;
                  } else {
                    return "Please provide a short description";
                  }
                },
                cursorHeight: 22,
                cursorWidth: 2,
                maxLines: 6,
                minLines: 1,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  labelText: "Short description about the transfer:",
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
              ),
            ),
            showLocation(),
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    serviceType = hotelORairport ? "Airport Transfer" : "Hotel Transfer";
                    nextPage(
                        context: context, page: const HotelAirportSummary());
                  }
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
    );
  }
}
