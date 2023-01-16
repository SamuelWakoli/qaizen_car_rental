import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../shared/constants.dart';

var textInputDecoration = InputDecoration(
  labelStyle: const TextStyle(fontWeight: FontWeight.w300),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Constants().primaryColor(),
      width: 2,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Constants().primaryColor(),
    ),
    borderRadius: BorderRadius.circular(10.0),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Constants().errorColor(),
      width: 2,
    ),
  ),
);

dynamic nextPage({required context, required page}) {
  Navigator.push(
      context, PageTransition(type: PageTransitionType.fade, child: page));
}

dynamic nextPageReplace({required context, required page}) {
  Navigator.pushReplacement(
      context, PageTransition(type: PageTransitionType.fade, child: page));
}

void showSnackbar(
    {required context, message, required duration, actionOnPressed}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
      ),
      duration: Duration(seconds: duration),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
      ),
    ),
  );
}

Widget normalWiderButton(
    {required context, required text, required onPressed}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    ),
  );
}

PopupMenuItem<int> optionMenuItem({
  required IconData icon,
  Color? color,
  required String text,
  required int position,
}) {
  return PopupMenuItem(
    value: position,
    child: ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(text),
    ),
  );
}
