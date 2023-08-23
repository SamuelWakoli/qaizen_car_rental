import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget selectVehiclesList({
  required context,
  required String id,
  required String appBarTitle,
  required String category,
  required String image,
  required String name,
  required String price,
  required bool availability,
  required onClickSelect,
  required onClickDetails,
}) {

  vehicleCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(24.0), // Adjust the radius as needed
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 4, right: 4),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: image,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        // Back
                        Text.rich(TextSpan(
                            text: name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 4
                                ..color = Colors.black,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                text: '  |  ',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              TextSpan(
                                text: availability ? "Available" : "Unavailable.",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Theme.of(context).primaryColor),
                              ),
                              TextSpan(
                                text: '  |  Ksh. $price /day',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ])),

                        // Front
                        Text.rich(
                          TextSpan(
                              text: name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              children: <TextSpan>[
                                const TextSpan(
                                  text: '  |  ',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                TextSpan(
                                  text:
                                  availability ? "Available" : "Unavailable.",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Theme.of(context).primaryColor),
                                ),
                                TextSpan(
                                  text: '  |  Ksh. $price /day',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: onClickDetails,
                  child: Text('Details',
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).primaryColor)),
                ),
                OutlinedButton(
                  onPressed: onClickSelect,
                  child: Text('Select',
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).primaryColor)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  if (appBarTitle == 'Hatchbacks' && category == 'Hatchback') {
    return vehicleCard();
  } else if (appBarTitle == 'Wagons' && category == 'Wagon') {
   return vehicleCard();
  } else if (appBarTitle == 'Sedans' && category == 'Sedan') {
   return vehicleCard();
  } else if (appBarTitle == 'Premium Sedans' && category == 'Premium Sedan') {
   return vehicleCard();
  } else if (appBarTitle == 'Vans' && category == 'Van') {
   return vehicleCard();
  } else if (appBarTitle == 'Compact SUVs' && category == 'Compact SUV') {
   return vehicleCard();
  } else if (appBarTitle == 'Premium SUVs' && category == 'Premium SUV') {
   return vehicleCard();
  } else if (appBarTitle == 'Luxury' && category == 'Luxury') {
   return vehicleCard();
  } else if (appBarTitle == "All Vehicles") {
   return vehicleCard();
  } else {
    if (appBarTitle == 'Hatchbacks' && category != 'Hatchback') {
      return const SizedBox();
    } else if (appBarTitle == 'Hatchbacks' && category != 'Hatchback') {
      return const SizedBox();
    } else if (appBarTitle == 'Wagons' && category != 'Wagon') {
      return const SizedBox();
    } else if (appBarTitle == 'Sedans' && category != 'Sedan') {
      return const SizedBox();
    } else if (appBarTitle == 'Premium Sedans' && category != 'Premium Sedan') {
      return const SizedBox();
    } else if (appBarTitle == 'Vans' && category != 'Van') {
      return const SizedBox();
    } else if (appBarTitle == 'Compact SUVs' && category != 'Compact SUV') {
      return const SizedBox();
    } else if (appBarTitle == 'Premium SUVs' && category != 'Premium SUV') {
      return const SizedBox();
    } else if (appBarTitle == 'Luxury' && category != 'Luxury') {
      return const SizedBox();
    } else {
      return ListTile(
        title: Text(
            'No $appBarTitle available at the moment. Please call us to reserve one.'),
      );
    }
  }
}
