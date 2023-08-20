import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:qaizen_car_rental/db/user.dart';

Widget availableVehicleCard({
  required context,
  required id,
  required image,
  required name,
  required price,
  required onClickHire,
  required onClickBook,
  required onClickDetails,
  required availability,
}) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
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
              LikeButton(
                isLiked: favoriteVehicles.contains(id),
                animationDuration: const Duration(milliseconds: 2500),
                bubblesColor: BubblesColor(
                    dotPrimaryColor: Theme.of(context).primaryColor,
                    dotSecondaryColor: Colors.white),
                circleColor: CircleColor(
                  start: Theme.of(context).primaryColor,
                  end: Colors.white,
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    color:
                        isLiked ? Theme.of(context).primaryColor : Colors.grey,
                    semanticLabel: isLiked
                        ? "Remove $name from favorites"
                        : "Add $name from favorites",
                    size: 32,
                  );
                },
                onTap: (isLiked) async {
                  if (!isLiked) {
                    favoriteVehicles.add(id);
                  } else {
                    favoriteVehicles.remove(id);
                  }
                  Map<String, dynamic> data = {"favorites": favoriteVehicles};
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userID)
                      .update(data)
                      .whenComplete(() {
                    String? likeMessage;
                    isLiked
                        ? likeMessage = "removed from"
                        : likeMessage = "added to";
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("$name $likeMessage bookmarks")));
                  });

                  return !isLiked;
                },
              ),
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
                onPressed: availability ? onClickHire : onClickBook,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.assignment_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(availability ? 'Hire' : "Book",
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
}
