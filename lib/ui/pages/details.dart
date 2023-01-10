import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/pages/hire.dart';
import 'package:qaizen_car_rental/ui/widgets/outlined_button.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('\$vehicleName'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              //vehicle images to be here.
              ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 400, minHeight: 250),
                child: Card(
                  elevation: 16,
                  shadowColor: Theme.of(context).primaryColor,
                  surfaceTintColor: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset('assets/cars/teslamodelx.jpg'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset('assets/cars/teslamodelx.jpg'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset('assets/cars/teslamodelx.jpg'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset('assets/cars/teslamodelx.jpg'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Price :',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Ksh 30,000 per day',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Ksh 200,000 per week',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '__ per month',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                  '(Short description sample text) Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
              const SizedBox(height: 20),
              outlinedButton(
                  context: context,
                  icon: Icons.assignment_outlined,
                  text: 'Hire',
                  onPressed: null),
            ]),
          ),
        ),
      ),
    );
  }
}
