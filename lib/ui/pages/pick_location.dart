import 'dart:async';

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
            selectLocationButtonText: 'Select Pinned Location',
            onError: (e) => print(e),
            onPicked: (pickedData) {
              print(pickedData.latLong.latitude);
              print(pickedData.latLong.longitude);
              print(pickedData.address);
              print(pickedData.addressData['country']);
              locationData = pickedData;
              Navigator.pop(context);
            }));
  }
}
