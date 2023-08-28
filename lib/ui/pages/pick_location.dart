import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared/hire_vehicle_data.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({super.key});

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  late GoogleMapController _controller;
  LatLng? _pickedLocation;
  final TextEditingController _searchController = TextEditingController();

  void _searchLocation() async {
    try {
      List<Location> locations =
          await locationFromAddress(_searchController.text);
      if (locations.isNotEmpty) {
        final LatLng searchedLocation =
            LatLng(locations[0].latitude, locations[0].longitude);
        _controller.animateCamera(CameraUpdate.newLatLng(searchedLocation));
        setState(() {
          _pickedLocation = searchedLocation;
        });
      }
    } catch (e) {
      // print("Error searching for location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tap on a Delivery Location',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search for a location',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _searchLocation,
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                _controller = controller;
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(-1.3028, 36.8848),
                zoom: 11,
              ),
              mapToolbarEnabled: true,
              myLocationEnabled: true,
              tiltGesturesEnabled: false,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              onTap: (location) async {
                final List<Placemark> placemarks =
                    await placemarkFromCoordinates(
                        location.latitude, location.longitude);

                if (placemarks.isNotEmpty) {
                  final Placemark placemark = placemarks[0];
                  final String address =
                      '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.country}';

                  // print("Tapped Location Address: $address");

                  setState(() {
                    _pickedLocation = location;
                    deliveryAddress = address.toString();
                    locationDataLat = _pickedLocation!.latitude;
                    locationDataLon = _pickedLocation!.longitude;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
