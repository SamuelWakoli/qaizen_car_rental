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
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0)),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: image,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
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
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Text.rich(TextSpan(
                  text: name,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
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
                      text: '  |  Ksh. $price /day ',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ])),
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
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  } else {
    return const SizedBox();
  }
}
