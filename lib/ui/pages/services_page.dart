import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/shared/hire_vehicle_data.dart';
import 'package:qaizen_car_rental/ui/pages/chauffeured.dart';
import 'package:qaizen_car_rental/ui/pages/corporate_service.dart';
import 'package:qaizen_car_rental/ui/pages/hotel_airport.dart';
import 'package:qaizen_car_rental/ui/pages/tours_safaris.dart';
import 'package:qaizen_car_rental/ui/pages/weddings_events.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';

import '../widgets/services_card.dart';
import 'self_drive.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              servicesCard(
                  context: context,
                  image: 'assets/driver.png',
                  label: 'Self Drive',
                  onTap: () {
                    selectedVehicles?.clear();
                    selectedVehicleNames?.clear();
                    driversNames?.clear();
                    serviceType = "Self Drive";
                    numberOfDays = '';
                   nextPage(context: context, page: const SelfDrive());
                  }),
              servicesCard(
                  context: context,
                  image: 'assets/car.png',
                  label: 'Chauffeured',
                  onTap: () {
                    selectedVehicles?.clear();
                    selectedVehicleNames?.clear();
                    driversNames?.clear();
                    serviceType = "Chauffeured";
                    numberOfDays = '';
                    nextPage(context: context, page: const ChauffeuredPage());
                  }),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              servicesCard(
                  context: context,
                  image: 'assets/teamwork.png',
                  label: 'Corporate Service',
                  onTap: () {
                    selectedVehicles?.clear();
                    selectedVehicleNames?.clear();
                    driversNames?.clear();
                    numberOfDays = '';
                    nextPage(
                        context: context, page: const CorporateServicePage());
                  }),
              servicesCard(
                  context: context,
                  image: 'assets/couple.png',
                  label: 'Weddings & Events',
                  onTap: () {
                    selectedVehicles?.clear();
                    selectedVehicleNames?.clear();
                    driversNames?.clear();
                    numberOfDays = '';
                    nextPage(context: context, page: const WeddingsEventsPage());
                  }),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              servicesCard(
                  context: context,
                  image: 'assets/photographer.png',
                  label: 'Tours & Safaris',
                  onTap: () {
                    selectedVehicles?.clear();
                    selectedVehicleNames?.clear();
                    driversNames?.clear();
                    numberOfDays = '';
                    nextPage(context: context, page: const ToursSafarisPage());
                  }),
              servicesCard(
                  context: context,
                  image: 'assets/airport.png',
                  label: "        Hotel &\nAirport Transfer",
                  onTap: () {
                    selectedVehicles?.clear();
                    selectedVehicleNames?.clear();
                    driversNames?.clear();
                    numberOfDays = '';
                    nextPage(context: context, page: const HotelAirportPage());
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
