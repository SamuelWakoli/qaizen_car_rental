import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/shared/constants.dart';

class Theming {
  var lightThemeData = ThemeData(
      primaryColor: Constants().primaryColor(),
      textTheme: const TextTheme(button: TextStyle(color: Colors.white70)),
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        elevation: 0,
      ),
      scaffoldBackgroundColor: Colors.white,
      tabBarTheme: const TabBarTheme(labelColor: Colors.black),
      indicatorColor: Constants().primaryColor(),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Constants().primaryColor(),
      ),
      useMaterial3: true);

  var darkThemeData = ThemeData(
      primaryColor: Constants().primaryColorDark(),
      textTheme: const TextTheme(button: TextStyle(color: Colors.black54)),
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        elevation: 0,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: Colors.lightBlueAccent,
      ),
      tabBarTheme: const TabBarTheme(labelColor: Colors.white),
      indicatorColor: Constants().primaryColor(),
      useMaterial3: true);
}
