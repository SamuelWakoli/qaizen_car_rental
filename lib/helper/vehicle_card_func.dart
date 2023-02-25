import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qaizen_car_rental/shared/hire_vehicle_data.dart';
import 'package:qaizen_car_rental/ui/pages/account_verification.dart';
import 'package:qaizen_car_rental/ui/pages/details.dart';
import 'package:url_launcher/url_launcher.dart';

import '../db/user.dart';
import '../ui/pages/hire.dart';
import '../ui/widgets/widgets.dart';

dynamic details({required context}) {
  nextPage(context: context, page: const VehicleDetailsPage());
}

dynamic hire({required context}) async {
  totalCost = 0;
  numberOfDays = '';
  driversNames = [];
  selectedVehicles = [];
  selectedVehicleNames = [];


  if (dbHasData) {
    serviceType = "Self Drive";
    nextPage(context: context, page: const HirePage());
  } else {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Profile Verification Required'),
            content: const Text(
              'Please get your profile verified to enjoy our services. If urgent, please call us',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  nextPage(context: context, page: const VerificationPage());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Verify Profile',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(ctx).pop();

                  //call
                  //when call permission is granted:
                  await FlutterPhoneDirectCaller.callNumber('+254797228948');
                  //else not granted, just show phone number
                  if (await Permission.phone.isDenied) {
                    final Uri launchUri = Uri(
                      scheme: 'tel',
                      path: '+254797228948',
                    );
                    await launchUrl(launchUri);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Call Us',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

//todo: Select()
