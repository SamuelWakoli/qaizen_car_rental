import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:qaizen_car_rental/db/user.dart';
import 'package:qaizen_car_rental/ui/pages/auth_gate.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';

Widget availableVehicleCard({
  required context,
  required id,
  required image,
  required name,
  required price,
  required onClickHire,
  required onClickDetails,
  required availability,
}) {
  if (availability) {
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
            const SizedBox(height: 8),
            Text.rich(TextSpan(
                text: name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                    text: '    Ksh. $price /day',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ])),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                (currentUser != null)
                    ? LikeButton(
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
                            color: isLiked
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
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
                          Map<String, dynamic> data = {
                            "favorites": favoriteVehicles
                          };
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(getUserName())
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
                      )
                    : IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  icon: Icon(
                                    Icons.account_circle_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  title: const Text("Authentication Required"),
                                  content: const Text(
                                      "To Add favorites, please sign in."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(ctx);
                                          nextPageReplace(
                                              context: context,
                                              page: const AuthGate());
                                        },
                                        child: const Text("Sign In")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(ctx);
                                        },
                                        child: const Text("Cancel")),
                                  ],
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.favorite_outline_rounded,
                          size: 30,
                        )),
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
