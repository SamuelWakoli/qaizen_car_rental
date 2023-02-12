import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';

import '../../shared/hire_vehicle_data.dart';

//ToDo: make these cards to only take vehicle IDs and extract data.
class AvailableVehicleCard extends StatefulWidget {
  String id, image, name, price;
  bool isLiked, availability;

  dynamic onClickHire, onClickDetails;

  AvailableVehicleCard({
    Key? key,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.isLiked,
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
    //default icon
    Widget iconToLoad = const Icon(Icons.favorite_outline_outlined);

    // //checked by database and setState
    // if (widget. == null) {
    //   if (widget.isLiked == true) {
    //     iconToLoad = const Icon(Icons.favorite_rounded);
    //   } else {
    //     iconToLoad = const Icon(Icons.favorite_outline_outlined);
    //   }
    // }

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
                    isLiked: widget.isLiked,
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
                      String likeMessage = "";
                      isLiked
                          ? likeMessage = "removed from"
                          : likeMessage = "added to";

                      showSnackbar(
                          context: context,
                          duration: 2,
                          message: "\$vehicleName $likeMessage to favorites");
                      return !isLiked;
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
    } else
      return SizedBox();
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
  required bool availabity,
  required onClickHire,
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
                    Text(availabity ? "Available" : "Not avalable")
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
}

///
///
///
///
///
class ReturningVehicleCard extends StatefulWidget {
  String id, image, name, price;
  bool isLiked, availabilityNotification, availability;

  dynamic onClickNotifyMe, onClickDetails;

  ReturningVehicleCard({
    Key? key,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.isLiked,
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
    //default icon
    Widget iconToLoad = const Icon(Icons.favorite_outline_outlined);

    // //checked by database and setState
    // if (widget. == null) {
    //   if (widget.isLiked == true) {
    //     iconToLoad = const Icon(Icons.favorite_rounded);
    //   } else {
    //     iconToLoad = const Icon(Icons.favorite_outline_outlined);
    //   }
    // }

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
                    isLiked: widget.isLiked,
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
                      String likeMessage = "";
                      isLiked
                          ? likeMessage = "removed from"
                          : likeMessage = "added to";

                      showSnackbar(
                          context: context,
                          duration: 2,
                          message: "\$vehicleName $likeMessage to favorites");
                      return !isLiked;
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
      return SizedBox();
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
  required bool availabity,
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
            child: Row(
              children: [
                const Text('Status: '),
                Text(availabity
                    ? "Available"
                    : "Not avalable, expected at \$availableTime")
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
