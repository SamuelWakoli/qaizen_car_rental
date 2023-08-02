import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/db/user.dart';

Widget favCard({
  required context,
  required String id,
  required String image,
  required String name,
  required String price,
  required bool availability,
  required onClickHire,
  required onClickDetails,
}) {
  if (favoriteVehicles.contains(id)) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(24.0), // Adjust the radius as needed
        ),
        child: Column(
          children: [
            Stack(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: onClickDetails,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        Text('Details',
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: onClickHire,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.assignment_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text('Hire',
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } else {
    return const SizedBox();
  }
}
