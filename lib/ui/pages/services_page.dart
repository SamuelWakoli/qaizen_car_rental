import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/pages/chauffeured.dart';
import 'package:qaizen_car_rental/ui/pages/corporate_service.dart';
import 'package:qaizen_car_rental/ui/pages/home_screen.dart';
import 'package:qaizen_car_rental/ui/pages/hotel_airport.dart';
import 'package:qaizen_car_rental/ui/pages/tours_safaris.dart';
import 'package:qaizen_car_rental/ui/pages/weddings_eventa.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';

import '../widgets/services_card.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 810),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  servicesCard(
                      context: context,
                      image: 'assets/driver.png',
                      label: 'Self Drive',
                      onTap: () {
                        setState(() {
                          showSnackbar(
                              context: context,
                              message:
                                  'Click "Home" to see available vehicles.',
                              duration: 5);
                        });
                      }),
                  servicesCard(
                      context: context,
                      image: 'assets/car.png',
                      label: 'Chauffeured',
                      onTap: () {
                        setState(() {
                          nextPage(context: context, page: const ChauffeuredPage());
                        });
                      }),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  servicesCard(
                      context: context,
                      image: 'assets/teamwork.png',
                      label: 'Corporate Service',
                      onTap: () {
                        setState(() {
                          nextPage(context: context, page: const CorporateServicePage());
                        });
                      }),
                  servicesCard(
                      context: context,
                      image: 'assets/couple.png',
                      label: 'Weddings & Events',
                      onTap: () {
                        setState(() {
                          nextPage(context: context, page: const WeddingsEventsPage());
                        });
                      }),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  servicesCard(
                      context: context,
                      image: 'assets/photographer.png',
                      label: 'Tours & Safaris',
                      onTap: () {
                        setState(() {
                          nextPage(context: context, page: const ToursSafarisPage());
                        });
                      }),
                  servicesCard(
                      context: context,
                      image: 'assets/airport.png',
                      label: "        Hotel &\nAirport Transfer",
                      onTap: () {
                        setState(() {
                          nextPage(context: context, page: const HotelAirportPage());
                        });
                      }),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
