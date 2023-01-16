import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/ui/pages/hire.dart';
import 'package:qaizen_car_rental/ui/widgets/material_button.dart';
import 'package:qaizen_car_rental/ui/widgets/widgets.dart';

import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\$vehicleName'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            //vehicle images to be here.
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ScrollLoopAutoScroll(
                scrollDirection: Axis.horizontal,
                delay: Duration(seconds: 5),
                duration: Duration(seconds: 20),
                reverseScroll: false,
                duplicateChild: 1,
                enableScrollInput: true,
                delayAfterScrollInput: Duration(seconds: 6),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 300, minHeight: 50),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            'assets/cars/teslamodelx.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 300, minHeight: 50),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            'assets/cars/axio.jpeg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 300, minHeight: 50),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            'assets/cars/crown.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 300, minHeight: 50),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            'assets/cars/note.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Ksh 50,000 per week',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '__ per month',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              '(Short description sample text) Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            materialButton(
              context: context,
              icon: Icons.assignment_outlined,
              text: 'Hire',
              onPressed: () =>
                  nextPage(context: context, page: const HirePage()),
            ),
          ]),
        ),
      ),
    );
  }
}
