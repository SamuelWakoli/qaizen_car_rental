import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:qaizen_car_rental/db/user.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';
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
                                title:
                                    const Text('Profile Verification Required'),
                                content: Text(
                                  'Please get your profile verified to perform this action.',
                                  style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                      nextPage(
                                          context: context,
                                          page: const VerificationPage());
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.verified_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(width: 20),
                                        Text(
                                          'Verify Profile',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
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
                  OutlinedButton(
                    onPressed: widget.onClickDetails,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline_rounded),
                          const SizedBox(width: 8),
                          Text('Details', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
                        ],
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: widget.onClickHire,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.assignment_outlined),
                          const SizedBox(width: 8),
                          Text('Hire', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
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
                      Text(availability
                          ? "Available"
                          : "Not available. Please call us to request it when available.")
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: onClickDetails,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children:  [
                        const Icon(Icons.info_outline_rounded),
                        const SizedBox(width: 8),
                        Text('Details', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onClickHire,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children:  [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Hire', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
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
                                title:
                                    const Text('Profile Verification Required'),
                                content: Text(
                                  'Please get your profile verified to perform this action.',
                                  style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                      nextPage(
                                          context: context,
                                          page: const VerificationPage());
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.verified_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(width: 20),
                                        Text(
                                          'Verify Profile',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
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
                  OutlinedButton(
                    onPressed: widget.onClickDetails,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline_rounded),
                          const SizedBox(width: 8),
                          Text('Details', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
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
                      ///add the vehicle to pending notifications
                      String notifyMessage = "";
                      availabilityNotification
                          ? notifyMessage = "not get"
                          : notifyMessage = "get";

                      showSnackbar(
                          context: context,
                          duration: 2,
                          message:
                              "You will $notifyMessage a notification when ${widget.name} is available");
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
///This will be used to generate various categories of vehicles using for loop
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
  if (appBarTitle == 'Hatchbacks' && category == 'Hatchback') {
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
              child: Text(availability
                  ? "Available"
                  : "Not available. Please call us to request it when available."),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.info_outline_rounded),
                        const SizedBox(width: 8),
                        Text('Details', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
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
  } else if (appBarTitle == 'Wagons' && category == 'Wagon') {
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
              child: Text(availability
                  ? "Available"
                  : "Not available. Please call us to request it when available."),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.info_outline_rounded),
                        const SizedBox(width: 8),
                        Text('Details', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
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
  } else if (appBarTitle == 'Sedans' && category == 'Sedan') {
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
              child: Text(availability
                  ? "Available"
                  : "Not available. Please call us to request it when available."),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.info_outline_rounded),
                        const SizedBox(width: 8),
                        Text('Details', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
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
  } else if (appBarTitle == 'Premium Sedans' && category == 'Premium Sedan') {
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
              child: Text(availability
                  ? "Available"
                  : "Not available. Please call us to request it when available."),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.info_outline_rounded),
                        const SizedBox(width: 8),
                        Text('Details', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
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
  } else if (appBarTitle == 'Vans' && category == 'Van') {
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
              child: Text(availability
                  ? "Available"
                  : "Not available. Please call us to request it when available."),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.info_outline_rounded),
                        const SizedBox(width: 8),
                        Text('Details', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
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
  } else if (appBarTitle == 'Compact SUVs' && category == 'Compact SUV') {
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
              child: Text(availability
                  ? "Available"
                  : "Not available. Please call us to request it when available."),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.info_outline_rounded),
                        const SizedBox(width: 8),
                        Text('Details', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
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
  } else if (appBarTitle == 'Premium SUVs' && category == 'Premium SUV') {
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
              child: Text(availability
                  ? "Available"
                  : "Not available. Please call us to request it when available."),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.info_outline_rounded),
                        const SizedBox(width: 8),
                        Text('Details', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
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
  } else if (appBarTitle == 'Luxury' && category == 'Luxury') {
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
              child: Text(availability
                  ? "Available"
                  : "Not available. Please call us to request it when available."),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.info_outline_rounded),
                        const SizedBox(width: 8),
                        Text('Details', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
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
  else if (appBarTitle == "All Vehicles"){
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
              child: Text(availability
                  ? "Available"
                  : "Not available. Please call us to request it when available."),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.info_outline_rounded),
                        const SizedBox(width: 8),
                        Text('Details', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children:  [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor))
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
  else {
    if (appBarTitle == 'Hatchbacks' && category != 'Hatchback') {
      return const SizedBox();
    } else if (appBarTitle == 'Hatchbacks' && category != 'Hatchback') {
      return const SizedBox();
    }  else if (appBarTitle == 'Wagons' && category != 'Wagon') {
      return const SizedBox();
    }  else if (appBarTitle == 'Sedans' && category != 'Sedan') {
      return const SizedBox();
    }  else if (appBarTitle == 'Premium Sedans' && category != 'Premium Sedan') {
      return const SizedBox();
    }  else if (appBarTitle == 'Vans' && category != 'Van') {
      return const SizedBox();
    }  else if (appBarTitle == 'Compact SUVs' && category != 'Compact SUV') {
      return const SizedBox();
    }  else if (appBarTitle == 'Premium SUVs' && category != 'Premium SUV') {
      return const SizedBox();
    }  else if (appBarTitle == 'Luxury' && category != 'Luxury') {
      return const SizedBox();
    } else {
      return ListTile(
        title: Text(
            'No $appBarTitle available at the moment. Please call us to reserve one.'),
      );
    }
  }
}
