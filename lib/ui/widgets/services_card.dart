import 'package:flutter/material.dart';

Widget servicesCard({
  required context,
  required String image,
  required String label,
  required dynamic onTap,
}) {
  return SizedBox(
    height: 140,
    width: 180,

    child: GestureDetector(
      onTap: onTap,
      child: Card(
        surfaceTintColor: Colors.transparent,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                child: Image.asset(
                  image,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
