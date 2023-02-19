import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:like_button/like_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qaizen_car_rental/db/user.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/hire_vehicle_data.dart';
import '../pages/account_verification.dart';

class AvailableVehicleCard extends StatefulWidget {
  String id, image, name, price;
  bool availability;

  dynamic onClickHire, onClickDetails;

  AvailableVehicleCard({
    Key? key,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.onClickHire,
    required this.onClickDetails,
    required this.availability,
  }) : super(key: key);

  @override
  State<AvailableVehicleCard> createState() => _AvailableVehicleCardState();
}

class _AvailableVehicleCardState extends State<AvailableVehicleCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.availability) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: widget.image,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                    value: downloadProgress.progress,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ksh. ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.price,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(' /day'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                         LikeButton(
                          isLiked: favoriteVehicles.contains(widget.id),
                          bubblesColor: BubblesColor(
                              dotPrimaryColor: Theme.of(context).primaryColor,
                              dotSecondaryColor: Colors.white),
                          circleColor: CircleColor(
                            start: Theme.of(context).primaryColor,
                            end: Colors.white,
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.favorite,
                              color: isLiked
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              size: 32,
                            );
                          },
                          onTap: ((isLiked) async {
                            if (dbHasData) {
                              if (!isLiked) {
                                favoriteVehicles.add(widget.id);
                              } else {
                                favoriteVehicles.remove(widget.id);
                              }
                              Map<String, dynamic> data = {
                                "favorites": favoriteVehicles
                              };
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(getUserName())
                                  .update(data)
                                  .whenComplete(() {
                                String likeMessage = "";
                                isLiked
                                    ? likeMessage = "removed from"
                                    : likeMessage = "added to";
                                showSnackbar(
                                    context: context,
                                    duration: 3,
                                    message:
                                        "${widget.name} $likeMessage to favorites");
                              });

                              return !isLiked;
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: const Text('Profile Verification Required'),
                                      content: const Text(
                                        'Please get your profile verified to perform this action.',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).popUntil((route) => route.isFirst);
                                            nextPage(context: context, page: const VerificationPage());
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.verified_outlined,
                                                color: Theme.of(context).primaryColor,
                                              ),
                                              const SizedBox(width: 20),
                                              Text(
                                                'Verify Profile',
                                                style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            }
                            return null;
                          }),
                        ),
                  GestureDetector(
                    onTap: widget.onClickDetails,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Icon(Icons.info_outline_rounded),
                          SizedBox(width: 8),
                          Text('Details', style: TextStyle(fontSize: 18))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onClickHire,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Icon(Icons.assignment_outlined),
                          SizedBox(width: 8),
                          Text('Hire', style: TextStyle(fontSize: 18))
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
}

///
///
///
///
///
Widget favCard({
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
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Ksh. ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(' /day'),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      const Text('Status: '),
                      Text(availability ? "Available" : "Not avalable")
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: onClickDetails,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(Icons.info_outline_rounded),
                        SizedBox(width: 8),
                        Text('Details', style: TextStyle(fontSize: 18))
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onClickHire,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(Icons.assignment_outlined),
                        SizedBox(width: 8),
                        Text('Hire', style: TextStyle(fontSize: 18))
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

///
///
///
///
///
class ReturningVehicleCard extends StatefulWidget {
  String id, image, name, price;
  bool availabilityNotification, availability;

  dynamic onClickNotifyMe, onClickDetails;

  ReturningVehicleCard({
    Key? key,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.availabilityNotification,
    required this.onClickNotifyMe,
    required this.onClickDetails,
    required this.availability,
  }) : super(key: key);

  @override
  State<ReturningVehicleCard> createState() => _ReturningVehicleCardState();
}

class _ReturningVehicleCardState extends State<ReturningVehicleCard> {
  @override
  Widget build(BuildContext context) {
    if (!widget.availability) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: widget.image,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                    value: downloadProgress.progress,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ksh. ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.price,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(' /day'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LikeButton(
                    isLiked: favoriteVehicles.contains(widget.id),
                    bubblesColor: BubblesColor(
                        dotPrimaryColor: Theme.of(context).primaryColor,
                        dotSecondaryColor: Colors.white),
                    circleColor: CircleColor(
                      start: Theme.of(context).primaryColor,
                      end: Colors.white,
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        size: 32,
                      );
                    },
                    onTap: ((isLiked) async {
                      if (dbHasData) {
                        if (!isLiked) {
                          favoriteVehicles.add(widget.id);
                        } else {
                          favoriteVehicles.remove(widget.id);
                        }
                        Map<String, dynamic> data = {
                          "favorites": favoriteVehicles
                        };
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(getUserName())
                            .update(data)
                            .whenComplete(() {
                          String likeMessage = "";
                          isLiked
                              ? likeMessage = "removed from"
                              : likeMessage = "added to";

                          showSnackbar(
                              context: context,
                              duration: 3,
                              message:
                                  "${widget.name} $likeMessage to favorites");
                        });

                        return !isLiked;
                      } else {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text('Profile Verification Required'),
                                content: const Text(
                                  'Please get your profile verified to perform this action.',
                                  style: TextStyle(fontSize: 18),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).popUntil((route) => route.isFirst);
                                      nextPage(context: context, page: const VerificationPage());
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.verified_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(width: 20),
                                        Text(
                                          'Verify Profile',
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            });
                      }
                      return null;
                    }),
                  ),
                  GestureDetector(
                    onTap: widget.onClickDetails,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Icon(Icons.info_outline_rounded),
                          SizedBox(width: 8),
                          Text('Details', style: TextStyle(fontSize: 18))
                        ],
                      ),
                    ),
                  ),
                  LikeButton(
                    isLiked: widget.availabilityNotification,
                    bubblesColor: BubblesColor(
                        dotPrimaryColor: Theme.of(context).primaryColor,
                        dotSecondaryColor: Colors.white),
                    circleColor: CircleColor(
                      start: Theme.of(context).primaryColor,
                      end: Colors.white,
                    ),
                    likeBuilder: (bool availabilityNotification) {
                      return Icon(
                        Icons.notification_add,
                        color: availabilityNotification
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        size: 32,
                      );
                    },
                    onTap: ((availabilityNotification) async {
                      ///add the vehivle to pending notifications
                      String notifyMessage = "";
                      availabilityNotification
                          ? notifyMessage = "not get"
                          : notifyMessage = "get";

                      showSnackbar(
                          context: context,
                          duration: 2,
                          message:
                              "You will $notifyMessage a notification when $vehicleName is available");
                      return !availabilityNotification;
                    }),
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
}

///
///
///
///This will be used to generate various categoties of vehicles using for loop
Widget selectVehiclesList({
  required context,
  required String id,
  required String image,
  required String name,
  required String price,
  required bool availability,
  required onClickSelect,
  required onClickDetails,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(image)),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  'Ksh. ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(' /day'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
            child: Text(availability ? "Available" : "Not available"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: onClickDetails,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(Icons.info_outline_rounded),
                      SizedBox(width: 8),
                      Text('Details', style: TextStyle(fontSize: 18))
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //get vehicle name

                  onClickSelect;
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(Icons.assignment_outlined),
                      SizedBox(width: 8),
                      Text('Select', style: TextStyle(fontSize: 18))
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
}
