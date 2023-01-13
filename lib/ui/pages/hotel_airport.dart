import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaizen_car_rental/ui/pages/pick_location.dart';
import 'package:qaizen_car_rental/ui/pages/terms_conditions.dart';

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

  bool acceptedTerms = false;
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

  Widget showVehicles() {
    if (hotelORairport == false) {
      return ListTile(
        onTap: () {},
        leading: Icon(
          Icons.car_rental_outlined,
          color: Theme.of(context).primaryColor,
          size: 32,
        ),
        title: Text(
          'Select vehicle(s)',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        subtitle: const Text(
          '\$selecedVehicles',
          style: TextStyle(fontSize: 16),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget showDrivers() {
    if (hotelORairport == false) {
      return ListTile(
        onTap: () {},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel & Airport Transfer'),
        centerTitle: true,
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
                    serviceType = "Hotel Transfer";
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
                    serviceType = "Airport Transfer";
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
              cursorHeight: 22,
              cursorWidth: 2,
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
          showVehicles(),
          showDrivers(),
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
                        context: context, page: const HotelAirportSummary())
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
