import 'package:flutter/material.dart';

///This data will be used to generate agreement pdf
bool? needDriver;

///shared var
String serviceType = "";
dynamic locationData = '';
dynamic locationDataLat;
dynamic locationDataLon;
String locationAddress = '';
String? selectedTime = '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
String? selectedDate =
    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
List<String>? driversNames = [];
List<String>? selectedVehicles = [];
String? numberOfDays = '';
int? totalCost = 00;

/// Hire
bool delivery = false;

/// Chauffeured
String? driverName = '';
String? vehicleName = '';

/// Corporate
String? orgName = '';

/// WedEvents

///Hotel Airport
String? hotelAirportName = "";
String? tranferDescription = "";
