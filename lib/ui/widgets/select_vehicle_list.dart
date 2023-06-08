import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
                MaterialButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded),
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
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select',
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
                MaterialButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded),
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
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select',
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
                MaterialButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded),
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
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select',
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
                MaterialButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded),
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
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select',
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
                MaterialButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded),
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
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select',
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
                MaterialButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded),
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
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select',
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
                MaterialButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded),
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
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select',
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
                MaterialButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded),
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
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select',
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
  } else if (appBarTitle == "All Vehicles") {
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
                MaterialButton(
                  onPressed: onClickDetails,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded),
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
                  onPressed: onClickSelect,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const Icon(Icons.assignment_outlined),
                        const SizedBox(width: 8),
                        Text('Select',
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
    if (appBarTitle == 'Hatchbacks' && category != 'Hatchback') {
      return const SizedBox();
    } else if (appBarTitle == 'Hatchbacks' && category != 'Hatchback') {
      return const SizedBox();
    } else if (appBarTitle == 'Wagons' && category != 'Wagon') {
      return const SizedBox();
    } else if (appBarTitle == 'Sedans' && category != 'Sedan') {
      return const SizedBox();
    } else if (appBarTitle == 'Premium Sedans' && category != 'Premium Sedan') {
      return const SizedBox();
    } else if (appBarTitle == 'Vans' && category != 'Van') {
      return const SizedBox();
    } else if (appBarTitle == 'Compact SUVs' && category != 'Compact SUV') {
      return const SizedBox();
    } else if (appBarTitle == 'Premium SUVs' && category != 'Premium SUV') {
      return const SizedBox();
    } else if (appBarTitle == 'Luxury' && category != 'Luxury') {
      return const SizedBox();
    } else {
      return ListTile(
        title: Text(
            'No $appBarTitle available at the moment. Please call us to reserve one.'),
      );
    }
  }
}
