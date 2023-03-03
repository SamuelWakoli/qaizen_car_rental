import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../db/user.dart';
import '../../shared/hire_vehicle_data.dart';

class HotelAirportSummary extends StatefulWidget {
  const HotelAirportSummary({super.key});

  @override
  State<HotelAirportSummary> createState() => _HotelAirportSummaryState();
}

class _HotelAirportSummaryState extends State<HotelAirportSummary> {
  bool loading = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
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
              clientName = document['name'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  summaryItem(name: 'Name: ', data: document['name']),
                  summaryItem(name: 'Phone Number: ', data: document['phone']),
                  summaryItem(
                      name: 'Email Address: ',
                      data:
                          FirebaseAuth.instance.currentUser!.email.toString()),
                  const SizedBox(height: 20),
                  summaryItem(name: 'Service: ', data: serviceType),
                  summaryItem(name: 'Name: ', data: hotelAirportName),
                  summaryItem(
                      name: 'Service description: ', data: transferDescription),
                  const SizedBox(height: 20),
                  if (!hotelORairport)
                    summaryItem(name: 'Location: ', data: deliveryAddress)
                  else
                    const SizedBox(),
                  summaryItem(
                      name: 'Duration: ',
                      data: "From $selectedTime $selectedDate"),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });

                          Map<String, dynamic> data = {
                            'name': clientName,
                            'userId': getUserName(),
                            'type': serviceType,
                            'starts': '$selectedTime | $selectedDate',
                            'duration': '',
                            'vehiclesList': [],
                            'driversList': [],
                            'orgName': '',
                            'delivery': delivery,
                            'delivery address': deliveryAddress,
                            'geo-point lat': locationDataLat.toString(),
                            'geo-point lon': locationDataLon.toString(),
                            'total cost': '',
                            'paid': false,
                            'status': 'Pending',
                            'hotel/airport name': hotelAirportName,
                            'transfer desc': transferDescription,
                          };

                          await Bookings.doc(
                                  "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}")
                              .set(data)
                              .whenComplete(() {
                            setState(() {
                              loading = false;
                            });

                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      title:
                                          const Text('Submitted Successfully'),
                                      content: const Text(
                                        'Your request has been received. We will send you an agreement document that will be signed upon payment. ',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      actions: [
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
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
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
              );
            }),
      )),
    );
  }
}
