import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaizen_car_rental/ui/pages/hire_summary.dart';
import 'package:qaizen_car_rental/ui/pages/pick_location.dart';

import '../../db/user.dart';
import '../../shared/hire_vehicle_data.dart';
import '../widgets/widgets.dart';
import 'auth_gate.dart';
import 'details.dart';
import 'view_image.dart';

class HirePage extends StatefulWidget {
  const HirePage({super.key});

  @override
  State<HirePage> createState() => _HirePageState();
}

class _HirePageState extends State<HirePage> {
  String displayImageUrl = "";
  bool editingAddress = false;

  Widget displayImage() {
    if (displayImageUrl != "") {
      return Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: displayImageUrl.toString(),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                value: downloadProgress.progress,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error_outline),
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  final formKey = GlobalKey<FormState>();

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

  Widget showDeliveryLocation() {
    if (delivery) {
      return ListTile(
          leading: Icon(
            Icons.location_on_outlined,
            size: 32,
            color: Theme.of(context).primaryColor,
          ),
          trailing: editingAddress
              ? const SizedBox()
              : IconButton(
                  tooltip: "Edit Address",
                  onPressed: () {
                    setState(() {
                      editingAddress = !editingAddress;
                    });
                  },
                  icon: const Icon(Icons.edit)),
          title: Text(
            'Select delivery location:',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          subtitle: editingAddress
              ? Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 16.0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      setState(() {
                        deliveryAddress = value;
                        editingAddress = !editingAddress;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        deliveryAddress = value;
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            editingAddress = !editingAddress;
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
              : Text(
                  deliveryAddress,
                  style: const TextStyle(fontSize: 16),
                ),
          onTap: () {
            nextPageReplace(context: context, page: const PickLocation());
          });
    } else {
      return const SizedBox();
    }
  }

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('vehicles')
            .doc(currentVehicleDocID)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          }

          final document = snapshot.data!;

          displayImageUrl = document.get('displayImageURL');

          return Scaffold(
            appBar: AppBar(
              title: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('vehicles')
                      .doc(currentVehicleDocID)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      );
                    }
                    return Text(snapshot.data!.get('name'));
                  }),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('vehicles')
                      .doc(currentVehicleDocID)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ));
                    }

                    final document = snapshot.data!;
                    return Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () {
                                    currentImageUrl = displayImageUrl;
                                    nextPage(
                                        context: context,
                                        page: const ViewImage());
                                  },
                                  child: displayImage()),
                              ListTile(
                                title: Text(document['category']),
                                subtitle: Text(
                                    "Price: Ksh. ${document["priceDay"]} /day"),
                                trailing: IconButton(
                                  onPressed: () {
                                    nextPage(
                                        context: context,
                                        page: const VehicleDetailsPage());
                                  },
                                  tooltip: "Details",
                                  icon: const Icon(Icons.info_outline),
                                ),
                              ),
                              const Divider(),
                              const Center(
                                child: Text(
                                  'Provide details for the following fields:',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ListTile(
                                leading: Icon(FontAwesomeIcons.clock,
                                    size: 32,
                                    color: Theme.of(context).primaryColor),
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
                              const SizedBox(height: 10),
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
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).primaryColor),
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
                              const Divider(),
                              const Center(
                                child: Text(
                                  'Delivery',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                  'Do you want the vehicle to be delivered to you? (Delivery fee applied)'),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 160,
                                    child: RadioListTile(
                                      title: const Text("Yes"),
                                      value: true,
                                      groupValue: delivery,
                                      onChanged: (value) {
                                        setState(() {
                                          delivery = value!;
                                        });
                                      },
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 160,
                                    child: RadioListTile(
                                      title: const Text("No"),
                                      value: false,
                                      groupValue: delivery,
                                      onChanged: (value) {
                                        setState(() {
                                          delivery = value!;
                                        });
                                      },
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              showDeliveryLocation(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OutlinedButton(
                                  onPressed: () async {
                                    numberOfDays != ''
                                        ? {
                                            selectedVehicles?.clear(),
                                            selectedVehicleNames?.clear(),
                                            selectedVehicles
                                                ?.add(currentVehicleDocID),
                                            totalCost = 0,
                                            totalCost = await getCost(),
                                            if (FirebaseAuth
                                                    .instance.currentUser !=
                                                null)
                                              {
                                                nextPage(
                                                    context: context,
                                                    page: const HireSummary())
                                              }
                                            else
                                              {
                                                showDialog(
                                                    context: context,
                                                    builder: (ctx) {
                                                      return AlertDialog(
                                                        icon: Icon(
                                                          Icons
                                                              .account_circle_outlined,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                        title: const Text(
                                                            "Authentication Required"),
                                                        content: const Text(
                                                            "Please sign in to continue."),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    ctx);
                                                                nextPage(
                                                                    context:
                                                                        context,
                                                                    page:
                                                                        const AuthGate());
                                                              },
                                                              child: const Text(
                                                                  "Sign In")),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    ctx);
                                                              },
                                                              child: const Text(
                                                                  "Cancel")),
                                                        ],
                                                      );
                                                    })
                                              }
                                          }
                                        : showSnackbar(
                                            context: context,
                                            duration: 4,
                                            message:
                                                'Please enter number of days.');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          ///use this location in the driver app
                                          'Next',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
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
                        ));
                  }),
            ),
          );
        });
  }
}
