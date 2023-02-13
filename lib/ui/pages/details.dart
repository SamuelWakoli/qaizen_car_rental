import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: image,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(
          value: downloadProgress.progress,
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error_outline),
      ),
    ),
  );
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  Widget displayImage() {
    if (displayImageUrl != null) {
      return Center(
        child: Card(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
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
            ],
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
            .doc(CurrentVehicleDocID)
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
                    displayImage(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Category: ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          document.get('category'),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const Center(
                        child: Text('Price',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    Text.rich(
                      TextSpan(
                          text: 'Ksh. ',
                          style: const TextStyle(fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: document.get('priceDay')),
                            const TextSpan(text: ' /day')
                          ]),
                    ),
                    Text.rich(
                      TextSpan(
                          text: 'Ksh. ',
                          style: const TextStyle(fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: document.get('priceWeek')),
                            const TextSpan(text: ' /week')
                          ]),
                    ),
                    Text.rich(
                      TextSpan(
                          text: 'Ksh. ',
                          style: TextStyle(fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: document.get('priceMonth')),
                            const TextSpan(text: ' /month')
                          ]),
                    ),
                    const SizedBox(height: 10),
                    const Center(
                        child: Text('Description',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    Text(
                      document.get('shortDesc'),
                    ),
                    const SizedBox(height: 10),
                    getVehicleImages(image1Url.toString()),
                    getVehicleImages(image2Url.toString()),
                    getVehicleImages(image3Url.toString()),
                    getVehicleImages(image4Url.toString()),
                    getVehicleImages(image5Url.toString()),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
