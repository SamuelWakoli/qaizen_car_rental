import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/shared/hire_vehicle_data.dart';
import 'package:qaizen_car_rental/ui/pages/chauffeured.dart';
import 'package:qaizen_car_rental/ui/pages/corporate_service.dart';
import 'package:qaizen_car_rental/ui/pages/hotel_airport.dart';
import 'package:qaizen_car_rental/ui/pages/tours_safaris.dart';
import 'package:qaizen_car_rental/ui/pages/weddings_events.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';

import '../widgets/services_card.dart';
import 'contact_us.dart';
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
          const SizedBox(height: 4),
          Card(
            surfaceTintColor: Colors.transparent,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  child: Image.asset(
                    'assets/slide5.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
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
                    deliveryAddress = '';
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
                    deliveryAddress = '';
                    nextPage(context: context, page: const ChauffeuredPage());
                  }),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              servicesCard(
                  context: context,
                  image: 'assets/teamwork.png',
                  label: 'Corporate \nService',
                  onTap: () {
                    selectedVehicles?.clear();
                    selectedVehicleNames?.clear();
                    driversNames?.clear();
                    numberOfDays = '';
                    serviceType = 'Corporate Service';
                    deliveryAddress = '';
                    nextPage(
                        context: context, page: const CorporateServicePage());
                  }),
              servicesCard(
                  context: context,
                  image: 'assets/couple.png',
                  label: 'Weddings \n& Events',
                  onTap: () {
                    selectedVehicles?.clear();
                    selectedVehicleNames?.clear();
                    driversNames?.clear();
                    numberOfDays = '';
                    serviceType = 'Weddings & Events';
                    deliveryAddress = '';
                    nextPage(
                        context: context, page: const WeddingsEventsPage());
                  }),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              servicesCard(
                  context: context,
                  image: 'assets/photographer.png',
                  label: 'Tours \n& Safaris',
                  onTap: () {
                    selectedVehicles?.clear();
                    selectedVehicleNames?.clear();
                    driversNames?.clear();
                    serviceType = 'Tours & Safaris';
                    numberOfDays = '';
                    deliveryAddress = '';
                    nextPage(context: context, page: const ToursSafarisPage());
                  }),
              servicesCard(
                  context: context,
                  image: 'assets/airport.png',
                  label: "Hotel / Airport \n Transfer",
                  onTap: () {
                    selectedVehicles?.clear();
                    selectedVehicleNames?.clear();
                    driversNames?.clear();
                    serviceType = "Hotel / Airport Transfer";
                    numberOfDays = '';
                    deliveryAddress = '';
                    nextPage(context: context, page: const HotelAirportPage());
                  }),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 12.0, left: 8, right: 8, bottom: 4),
            child: Text(
              "Didn't find the service you're looking "
              "for? We've got you covered! Contact us "
              "for a customized solution.",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 4.0, bottom: 4, left: 8, right: 8),
            child: ElevatedButton(
              onPressed: () {
                nextPage(context: context, page: const ContactUsPage());
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.contact_support_outlined),
                  SizedBox(width: 8),
                  Text("Contact Us"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
