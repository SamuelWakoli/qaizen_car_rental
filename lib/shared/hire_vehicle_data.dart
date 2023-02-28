import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/db/user.dart';

///This data will be used to generate agreement pdf
///shared var
String clientName = getUserName();
bool driverNeeded = false;
String serviceType = "";
dynamic locationDataLat;
dynamic locationDataLon;
String? selectedTime = '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
String? selectedDate =
    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
List<String>? driversNames = [];
List<String>? selectedVehicles = [];
List<String>? selectedVehicleNames = [];
String? numberOfDays = '';
int? totalCost = 00;

/// Hire
bool delivery = false;
String deliveryAddress = '';

/// Chauffeured
String? driverName = '';
String? vehicleName = '';

/// Corporate
String? orgName = '';

///Hotel Airport
bool hotelORairport = false; //false for hotel
String? hotelAirportName = "";
String? transferDescription = "";

//Get cost
Future<int?> getCost() async {
  for (int i = 0; i < selectedVehicles!.length; i++) {
    int priceDay = 0;
    String priceDayString = '';
    await FirebaseFirestore.instance
        .collection('vehicles')
        .doc(selectedVehicles![i])
        .get()
        .then((value) {
      priceDayString = value['priceDay'];
    });
    priceDayString = priceDayString.replaceAll(",", "");
    priceDay = int.parse(priceDayString);
    totalCost = (totalCost! + priceDay);
  }

  int days = int.parse(numberOfDays!);
  return totalCost! * days;
}
