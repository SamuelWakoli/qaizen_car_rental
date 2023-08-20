import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qaizen_car_rental/helper/communication.dart';
import 'package:qaizen_car_rental/ui/pages/details.dart';
import 'package:qaizen_car_rental/ui/pages/view_image.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';

import '../../db/user.dart';
import '../../shared/hire_vehicle_data.dart';
import 'pick_location.dart';

class BookVehicle extends StatefulWidget {
  const BookVehicle({super.key});

  @override
  State<BookVehicle> createState() => _BookVehicleState();
}

String displayImageUrl = "", whatsappMessage = "";

Widget getVehicleImages(image) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: image,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          ),
        ),
        errorWidget: (context, url, error) => const SizedBox(),
      ),
    ),
  );
}

class _BookVehicleState extends State<BookVehicle> {
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

  TimeOfDay currentTime = TimeOfDay.now();

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
          title: Text(
            'Select delivery location:',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          subtitle: Text(
            deliveryAddress,
            style: const TextStyle(fontSize: 16),
          ),
          onTap: () {
            nextPage(context: context, page: const PickLocation());
          });
    } else {
      return const SizedBox();
    }
  }

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
          whatsappMessage =
              "Hello,\nI would like book a ${document['name']} when available.";

          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Book: ${document.get('name')}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  GestureDetector(
                      onTap: () {
                        currentImageUrl = displayImageUrl;
                        nextPage(context: context, page: const ViewImage());
                      },
                      child: displayImage()),
                  ListTile(
                    title: Text(document['category']),
                    subtitle: Text("Price: Ksh. ${document["priceDay"]}"),
                    trailing: IconButton(
                      onPressed: () {
nextPage(context: context, page: const VehicleDetailsPage());
                      },
                      tooltip: "Details",
                      icon: const Icon(Icons.info_outline),
                    ),
                  ),
                  const Text(
                      "The vehicle you are interested in is currently unavailable. "
                      "It might be in use by another client and its rental period "
                      "could be extended. Thank you for your understanding."),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          sendWhatsAppMessage(message: whatsappMessage);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.whatsapp),
                            SizedBox(width: 8),
                            Text("Book When Available"),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
