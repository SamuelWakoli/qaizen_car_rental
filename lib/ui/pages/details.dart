import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/pages/view_image.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';

import '../../db/user.dart';

class VehicleDetailsPage extends StatefulWidget {
  const VehicleDetailsPage({super.key});

  @override
  State<VehicleDetailsPage> createState() => _VehicleDetailsPageState();
}

String? displayImageUrl = "",
    image1Url = "",
    image2Url = "",
    image3Url = "",
    image4Url = "",
    image5Url = "";

Widget getVehicleImages(image) {
  return Padding(
    padding: const EdgeInsets.only(top: 4, bottom: 4),
    child: Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
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
            errorWidget: (context, url, error) => const SizedBox(),
          ),
        ),
      ),
    ),
  );
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  Widget displayImage() {
    if (displayImageUrl != null) {
      return Center(
        child: Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
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
        ),
      );
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
          image1Url = document.get('image1URL');
          image2Url = document.get('image2URL');
          image3Url = document.get('image3URL');
          image4Url = document.get('image4URL');
          image5Url = document.get('image5URL');

          return Scaffold(
            appBar: AppBar(
              title: Text(
                document.get('name'),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          currentImageUrl = displayImageUrl!;
                          nextPage(context: context, page: const ViewImage());
                        },
                        child: displayImage()),
                    Card(
                      elevation: 1,
                      child: ListTile(
                        title: Text("${document.get('category')}\nPrice"),
                        subtitle: Text("Ksh. ${document.get('priceDay')} /day\n"
                            "Ksh. ${document.get('priceWeek')} /day\n"
                            "Ksh. ${document.get('priceMonth')} /day"),
                      ),
                    ),
                    (document.get('shortDesc') != "" &&
                            document.get('shortDesc') != " ")
                        ? Card(elevation: 1,
                            child: ListTile(
                                title: Text(document.get('shortDesc'))))
                        : SizedBox(),
                    GestureDetector(
                        onTap: () {
                          currentImageUrl = image1Url!;
                          nextPage(context: context, page: const ViewImage());
                        },
                        child: getVehicleImages(image1Url.toString())),
                    GestureDetector(
                        onTap: () {
                          currentImageUrl = image2Url!;
                          nextPage(context: context, page: const ViewImage());
                        },
                        child: getVehicleImages(image2Url.toString())),
                    GestureDetector(
                        onTap: () {
                          currentImageUrl = image3Url!;
                          nextPage(context: context, page: const ViewImage());
                        },
                        child: getVehicleImages(image3Url.toString())),
                    GestureDetector(
                        onTap: () {
                          currentImageUrl = image4Url!;
                          nextPage(context: context, page: const ViewImage());
                        },
                        child: getVehicleImages(image4Url.toString())),
                    GestureDetector(
                        onTap: () {
                          currentImageUrl = image5Url!;
                          nextPage(context: context, page: const ViewImage());
                        },
                        child: getVehicleImages(image5Url.toString())),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
