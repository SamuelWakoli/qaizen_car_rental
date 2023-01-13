import 'package:flutter/material.dart';

import '../../shared/hire_vehicle_data.dart';

class ChauffeuredSummary extends StatefulWidget {
  const ChauffeuredSummary({super.key});

  @override
  State<ChauffeuredSummary> createState() => _ChauffeuredSummaryState();
}

class _ChauffeuredSummaryState extends State<ChauffeuredSummary> {
  TextStyle normalText() {
    return const TextStyle(fontSize: 16);
  }

  TextStyle boldText() {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  }

  dynamic summaryItem({required name, required data}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Text.rich(TextSpan(
        text: name,
        style: const TextStyle(fontSize: 16),
        children: <TextSpan>[
          TextSpan(
            text: data,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            summaryItem(name: 'Name: ', data: '\$userName'),
            summaryItem(name: 'Phone Number: ', data: '\$phone'),
            summaryItem(name: 'National ID Number: ', data: '\$natIDnum'),
            summaryItem(name: 'Email Address: ', data: '\$email'),
            const SizedBox(height: 20),
            summaryItem(name: 'Vehicle: ', data: '\$vehicleName'),
            
            summaryItem(name: 'Driver: ', data: driverName),
            summaryItem(name: 'Time: ', data: '$driverName'),
            summaryItem(name: 'Number of Days: ', data: numberOfDays),
            const SizedBox(height: 30),
            summaryItem(name: "TOTAL COST: ", data: "Ksh. $totalCost"),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ///use this location in the driver app
                        'Generate Agreement Document',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}