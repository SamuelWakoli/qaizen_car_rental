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
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardTheme:
          CardTheme(elevation: 8, shadowColor: Constants().primaryColor()),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Constants().primaryColor(),
        selectedIconTheme: const IconThemeData(size: 32),
        selectedLabelStyle: const TextStyle(fontSize: 16),
        unselectedItemColor: Colors.grey[900],
      ),
      useMaterial3: true);

  var darkThemeData = ThemeData(
      primaryColor: Constants().primaryColorDark(),
      textTheme: const TextTheme(button: TextStyle(color: Colors.black54)),
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        elevation: 0,
      ),
      drawerTheme: const DrawerThemeData(),
      navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: Colors.lightBlueAccent,
      ),
      tabBarTheme: const TabBarTheme(labelColor: Colors.white),
      indicatorColor: Constants().primaryColor(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardTheme:
          CardTheme(elevation: 8, shadowColor: Constants().primaryColor()),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Constants().primaryColorDark(),
        selectedIconTheme: const IconThemeData(size: 32),
        selectedLabelStyle: const TextStyle(fontSize: 16),
        unselectedItemColor: Colors.white70,
      ),
      useMaterial3: true);
}
