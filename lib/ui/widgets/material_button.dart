import 'package:flutter/material.dart';

Widget materialButton({
  required context,
  required IconData icon,
  required String text,
  required void onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: MaterialButton(
      onPressed: () => onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget materialButtonIconRight({
  required context,
  required IconData icon,
  required String text,
  required void onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: MaterialButton(
      onPressed: () => onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    ),
  );
}
