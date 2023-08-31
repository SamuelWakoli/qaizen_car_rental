import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:qaizen_car_rental/ui/pages/tours_safaris.dart';
import 'package:qaizen_car_rental/ui/pages/weddings_events.dart';

import '../../shared/hire_vehicle_data.dart';
import '../widgets/widgets.dart';
import 'chauffeured.dart';
import 'corporate_service.dart';
import 'hire.dart';
import 'hotel_airport.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({super.key});

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  LatLng initialLocation = const LatLng(-1.3028, 36.8848);
  String address = "null";
  String autocompletePlace = "null";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapLocationPicker(
        apiKey: "AIzaSyCNeHhDpgD94UG727Z3UezXdGjwPqprBJg",
        // popOnNextButtonTaped: true,
        searchHintText: "Search Location",
        compassEnabled: true,
        hideBackButton: true,
        hideMapTypeButton: true,
        currentLatLng: initialLocation,
        topCardColor: Theme.of(context).colorScheme.primaryContainer,
        bottomCardIcon: Icon(
          Icons.arrow_forward,
          size: 36,
          color: Theme.of(context).primaryColor,
        ),
        hideMoreOptions: true,
        onNext: (GeocodingResult? result) {
          if (result != null) {
            setState(() {
              address = result.formattedAddress ?? "";
            });

            setState(() {
              deliveryAddress = address.toString();
              locationDataLat = result.geometry.location.lat;
              locationDataLon = result.geometry.location.lng;
            });

            // using this logic to rebuild a page;
            late Widget currentService;
            switch (serviceType) {
              case "Self Drive":
                currentService = const HirePage();
                break;
              case "Chauffeured":
                currentService = const ChauffeuredPage();
                break;
              case "Corporate Service":
                currentService = const CorporateServicePage();
                break;
              case "Weddings & Events":
                currentService = const WeddingsEventsPage();
                break;
              case "Tours & Safaris":
                currentService = const ToursSafarisPage();
                break;
              case "Hotel / Airport Transfer":
                currentService = const HotelAirportPage();
                break;
            }

            nextPageReplace(context: context, page: currentService);
          }
        },
        onSuggestionSelected: (PlacesDetailsResponse? result) {
          if (result != null) {
            setState(() {
              autocompletePlace = result.result.formattedAddress ?? "";
            });
          }
        },
      ),
    );
  }
}
