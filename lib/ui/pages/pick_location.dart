import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../shared/hire_vehicle_data.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({super.key});

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterLocationPicker(
            initZoom: 11,
            minZoomLevel: 5,
            maxZoomLevel: 16,
            trackMyPosition: true,
            searchBarBackgroundColor: Colors.white,
            mapLoadingBackgroundColor: Colors.white,
            searchBarHintColor: Theme.of(context).primaryColor,
            searchBarTextColor: Theme.of(context).primaryColor,
            selectLocationButtonText: 'Select Pinned Location',
            onError: (e) {
              // print(e);
            },
            onPicked: (pickedData) async {
              // print(pickedData.latLong.latitude);
              // print(pickedData.latLong.longitude);
              // print(pickedData.address);
              // print(pickedData.addressData['country']);
              setState(() {
                deliveryAddress = pickedData.address.toString();
                locationDataLat = pickedData.latLong.latitude;
                locationDataLon = pickedData.latLong.longitude;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(deliveryAddress),
                duration: const Duration(seconds: 5),
              ));
            }));
  }
}
