import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget driverCard({
  required context,
  required String id,

  ///Get all data from the ID, and remove these params
  required String image,
  required String name,
  required String gender,
  required bool availability,
  required onClickSelect,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () {
        //Get driver's name
        //pop context
        Navigator.pop(context);
      },
      child: Card(
        child: Row(
          children: [
            SizedBox(
              height: 128,
              width: 128,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: image,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                        value: downloadProgress.progress,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Row(
                    children: [
                      const Text(
                        'Gender: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        gender,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        availability
                            ? "Available"
                            : "Not available",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: const [
                        Icon(Icons.assignment_outlined),
                        SizedBox(width: 8),
                        Text('Select', style: TextStyle(fontSize: 18))
                      ],
                    ),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    ),
  );
}
