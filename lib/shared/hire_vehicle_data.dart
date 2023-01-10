import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

bool? deliveryService;
PickedData? locationData;
String? price;
String selectedTime = '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
String selectedDate =
    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
String numberOfDays = '';
String? duration;
