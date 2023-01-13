import 'package:flutter/material.dart';

Widget servicesCard({
  required context,
  required String image,
  required String label,
  required dynamic onTap,
}) {
  return ConstrainedBox(
    constraints: const BoxConstraints(minHeight: 190, minWidth: 180),
    child: GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        shadowColor: Theme.of(context).primaryColor,
        elevation: 4,
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 140, maxHeight: 120),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  image,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}
