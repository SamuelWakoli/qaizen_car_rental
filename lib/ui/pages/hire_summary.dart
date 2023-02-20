import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/db/user.dart';
import 'package:qaizen_car_rental/ui/pages/active_service.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';

import '../../shared/hire_vehicle_data.dart';

class HireSummary extends StatefulWidget {
  const HireSummary({super.key});

  @override
  State<HireSummary> createState() => _HireSummaryState();
}

class _HireSummaryState extends State<HireSummary> {
  TextStyle normalText() {
    return const TextStyle(fontSize: 16);
  }

  TextStyle boldText() {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  }

  dynamic summaryItem({required name, required data}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Text.rich(TextSpan(
        text: name,
        style: const TextStyle(fontSize: 16),
        children: <TextSpan>[
          TextSpan(
            text: data,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )
        ],
      )),
    );
  }

  String costDay = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(getUserName())
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              );
            }

            final document = snapshot.data!;
            return SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  summaryItem(name: 'Name: ', data: document['name']),
                  summaryItem(name: 'Phone Number: ', data: document['phone']),
                  summaryItem(
                      name: 'Email Address: ',
                      data:
                          FirebaseAuth.instance.currentUser!.email.toString()),
                  const SizedBox(height: 20),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('vehicles')
                          .doc(CurrentVehicleDocID)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return summaryItem(
                            name: 'Vehicle: ',
                            data: snapshot.data!.get('name'));
                      }),
                  summaryItem(
                      name: 'Service starts at: ',
                      data: ' $selectedTime | $selectedDate'),
                  delivery
                      ? summaryItem(
                          name: 'Delivery Location: ', data: deliveryAddress)
                      : const SizedBox(),
                  const SizedBox(height: 30),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('vehicles')
                          .doc(CurrentVehicleDocID)
                          .snapshots(),
                      builder: (context, snapshot) {
                        String costDay = snapshot.data!.get('priceDay');
                        //remove comma from priceDay
                        costDay = costDay.replaceAll(',', '');
                        totalCost = int.parse(costDay);
                        totalCost = (totalCost! * int.parse(numberOfDays!));
                        vehicleName = snapshot.data!.get('name');
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            summaryItem(
                                name: 'Number of Days: ', data: numberOfDays),
                            summaryItem(name: 'Price per day: ', data: costDay),
                            summaryItem(
                                name: "COST: ",
                                data:
                                    "Ksh. $totalCost ${delivery ? '(exclusive of delivery fee)' : ''}")
                          ],
                        );
                      }),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });

                          Map<String, dynamic> data = {
                            'type': 'Self Drive',
                            'starts': '$selectedTime | $selectedDate',
                            'duration': numberOfDays,
                            'vehiclesList': [CurrentVehicleDocID],
                            //get vehicle ids
                            'driversList': [],
                            //get driver names
                            'orgName': '',
                            'delivery': delivery,
                            'delivery address': deliveryAddress,
                            'geo-point lat': locationDataLat.toString(),
                            'geo-point lon': locationDataLon.toString(),
                            'total cost': totalCost,
                            'paid': false,
                            'status': 'Pending',
                          };

                          await Bookings.set(data).whenComplete(() {
                            setState(() {
                              loading = false;
                            });

                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      title:
                                          const Text('Submitted Successfully'),
                                      content: const Text(
                                          'Your request has been received. We will send you an agreement document that will be signed upon payment. '),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).popUntil(
                                                (route) => route.isFirst);
                                            nextPage(
                                                context: context,
                                                page: const ActiveService());
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .supervised_user_circle_outlined,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              const SizedBox(width: 20),
                                              Text(
                                                'View Active Service',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.of(context)
                                              .popUntil(
                                                  (route) => route.isFirst),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.home_outlined,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              const SizedBox(width: 20),
                                              Text(
                                                'Go to Home Screen',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ));
                          }).onError(
                            (error, stackTrace) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('An error occurred: $error'),
                              ),
                            ),
                          );
                        },
                        child: loading
                            ? CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Submit Request',
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
                  ),
                ],
              ),
            ));
          }),
    );
  }
}
