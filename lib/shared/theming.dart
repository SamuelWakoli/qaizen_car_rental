import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/shared/constants.dart';

class Theming {
  var lightThemeData = ThemeData(
      primaryColor: Constants().primaryColor(),
      textTheme: const TextTheme(button: TextStyle(color: Colors.white70)),
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        color: Constants().primaryColor(),
      ));

  var darkThemeData = ThemeData(
    primaryColor: Constants().primaryColorDark(),
    textTheme: const TextTheme(button: TextStyle(color: Colors.black54)),
    brightness: Brightness.dark,
  );
}
