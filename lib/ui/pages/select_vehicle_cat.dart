import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/pages/cat_compactsuvs.dart';
import 'package:qaizen_car_rental/ui/pages/cat_hatchbacks.dart';
import 'package:qaizen_car_rental/ui/pages/cat_luxury.dart';
import 'package:qaizen_car_rental/ui/pages/cat_premiumsedans.dart';
import 'package:qaizen_car_rental/ui/pages/cat_premiumsuvs.dart';
import 'package:qaizen_car_rental/ui/pages/cat_sedans.dart';
import 'package:qaizen_car_rental/ui/pages/cat_vans.dart';
import 'package:qaizen_car_rental/ui/pages/cat_wagons.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';

class SelectVehicleCat extends StatefulWidget {
  const SelectVehicleCat({super.key});

  @override
  State<SelectVehicleCat> createState() => _SelectVehicleCatState();
}

class _SelectVehicleCatState extends State<SelectVehicleCat> {
  Widget _vehicleCard({
    required context,
    required String image,
    required String label,
    required dynamic onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Card(
              color: Colors.white,
              shadowColor: Theme.of(context).primaryColor,
              elevation: 4,
              child: Column(
                children: [
                  ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 180,
                        maxWidth: 160,
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(image, fit: BoxFit.fill))),
                ],
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  ///hatchbacks = vits, fit, note, demio
  ///wagons = fielder, fit shuttle, wish
  ///vans = noah, voxy,
  ///sedans = axio, allion, premio
  ///premium sedans = corolla, Camry, Avalon, Mirai, Crown.
  ///Compact SUVs = x-trail, vanguard, harrier
  ///premium SUVs = prado 120s, prado 150s, v8
  ///Luxury = convertible, benz, range rover,
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicles'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Select Category',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _vehicleCard(
                        context: context,
                        image: 'assets/vehiclecategories/hatchbacks.jpg',
                        label: 'Hatchbacks',
                        onTap: () {
                          Navigator.pop(context);
                          nextPage(
                              context: context, page: const CatHatchbacks());
                        }),
                    _vehicleCard(
                        context: context,
                        image: 'assets/vehiclecategories/wagons.jpg',
                        label: 'Wagons',
                        onTap: () {
                          Navigator.pop(context);
                          nextPage(context: context, page: const CatWagons());
                        }),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _vehicleCard(
                        context: context,
                        image: 'assets/vehiclecategories/sedans.jpg',
                        label: 'Sedans',
                        onTap: () {
                          Navigator.pop(context);
                          nextPage(context: context, page: const CatSedans());
                        }),
                    _vehicleCard(
                        context: context,
                        image: 'assets/vehiclecategories/premiumsedans.jpg',
                        label: 'Premium Sedans',
                        onTap: () {
                          Navigator.pop(context);
                          nextPage(
                              context: context, page: const CatPremiumSedans());
                        }),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _vehicleCard(
                        context: context,
                        image: 'assets/vehiclecategories/vans.jpg',
                        label: 'Vans',
                        onTap: () {
                          Navigator.pop(context);
                          nextPage(context: context, page: const CatVans());
                        }),
                    _vehicleCard(
                        context: context,
                        image: 'assets/vehiclecategories/compactsuvs.jpg',
                        label: 'Compact SUVs',
                        onTap: () {
                          Navigator.pop(context);
                          nextPage(
                              context: context, page: const CatCompactSuvs());
                        }),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _vehicleCard(
                        context: context,
                        image: 'assets/vehiclecategories/premiumsuvs.jpg',
                        label: 'Premium SUVs',
                        onTap: () {
                          Navigator.pop(context);
                          nextPage(
                              context: context, page: const CatPremiumSuvs());
                        }),
                    _vehicleCard(
                        context: context,
                        image: 'assets/vehiclecategories/luxury.jpg',
                        label: 'Luxury',
                        onTap: () {
                          Navigator.pop(context);
                          nextPage(context: context, page: const CatLuxury());
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('All Vehicles'),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
