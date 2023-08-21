import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../db/user.dart';
import '../../shared/hire_vehicle_data.dart';

class ToursSafarisSummary extends StatefulWidget {
  const ToursSafarisSummary({super.key});

  @override
  State<ToursSafarisSummary> createState() => _ToursSafarisSummaryState();
}

class _ToursSafarisSummaryState extends State<ToursSafarisSummary> {
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

  bool loading = false;
  bool editingPhone = false;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  summaryItem(name: 'Name: ', data: clientName),
                  Row(
                    children: [
                      summaryItem(name: 'Phone Number: ', data: phoneNumber),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              editingPhone = !editingPhone;
                            });
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  ),
                  editingPhone
                      ? Padding(
                          padding: const EdgeInsets.only(
                              right: 16.0, left: 16.0, bottom: 16.0),
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (value) {
                              setState(() {
                                phoneNumber = value;
                                editingPhone = !editingPhone;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                phoneNumber = value;
                              });
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    editingPhone = !editingPhone;
                                  });
                                },
                                icon: Icon(
                                  Icons.done,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  summaryItem(
                      name: 'Email Address: ',
                      data:
                          FirebaseAuth.instance.currentUser!.email.toString()),
                  const SizedBox(height: 20),
                  summaryItem(name: 'Destination: ', data: deliveryAddress),
                  summaryItem(
                      name: 'Vehicle(s): ',
                      data: selectedVehicleNames?.join(", ")),
                  summaryItem(
                      name: 'Driver(s): ', data: driversNames?.join(", ")),
                  summaryItem(
                      name: 'Service starts at: ',
                      data: ' $selectedTime | $selectedDate'),
                  summaryItem(name: 'Number of Days: ', data: numberOfDays),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });

                          Map<String, dynamic> phoneData = {
                            'phone': phoneNumber,
                          };
                          await fireStoreUserData.update(phoneData);

                          Map<String, dynamic> data = {
                            'name': clientName,
                            'userId': userID,
                            'fCMToken': fCMToken,
                            'phone': phoneNumber,
                            'type': serviceType,
                            'starts': '$selectedTime | $selectedDate',
                            'duration': numberOfDays,
                            'vehiclesList': selectedVehicles,
                            'driversList': driversNames,
                            'orgName': '',
                            'delivery': delivery,
                            'delivery address': '',
                            'geo-point lat': '',
                            'geo-point lon': '',
                            'paid': false,
                            'status': 'Pending',
                            'hotel/airport name': hotelAirportName,
                            'transfer desc': transferDescription,
                          };

                          await userBookings
                              .doc("${DateTime.now()}")
                              .set(data)
                              .whenComplete(() {
                            setState(() {
                              loading = false;
                            });
                            Navigator.popUntil(
                                context, (route) => route.isFirst);

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
                                          onPressed: () => Navigator.pop(ctx),
                                          child: Text(
                                            'Okay',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
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
              ))),
    );
  }
}
