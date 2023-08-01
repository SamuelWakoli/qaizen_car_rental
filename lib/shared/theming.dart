import 'package:flutter/material.dart';
import 'package:qaizen_car_rental/shared/constants.dart';

class Theming {
  var lightThemeData = ThemeData(
      primaryColor: Constants().primaryColor(),
      textTheme: const TextTheme(labelLarge: TextStyle(color: Colors.white70)),
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        elevation: 0,
        surfaceTintColor: Constants().primaryColor(),
        color: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.white,
      tabBarTheme: const TabBarTheme(labelColor: Colors.black),
      indicatorColor: Constants().primaryColor(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardTheme: CardTheme(
        elevation: 4,
        shadowColor: Constants().primaryColor(),
        surfaceTintColor: Constants().primaryColor(),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Constants().primaryColor(),
        selectedIconTheme: const IconThemeData(size: 32),
        selectedLabelStyle: const TextStyle(fontSize: 16),
        unselectedItemColor: Colors.grey[900],
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Constants().primaryColor())),
      ),
      drawerTheme:
          DrawerThemeData(surfaceTintColor: Constants().primaryColor()),
      popupMenuTheme:
          PopupMenuThemeData(surfaceTintColor: Constants().primaryColor()),
      dialogTheme: DialogTheme(surfaceTintColor: Constants().primaryColor()),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          surfaceTintColor: MaterialStateProperty.resolveWith((states) {
            return Constants().primaryColor();
          }),
          textStyle: MaterialStateProperty.resolveWith((states) {
            return TextStyle(color: Constants().primaryColor());
          }),
        ),
      ),
      // timePickerTheme: TimePickerThemeData(
      //   hourMinuteTextColor: Constants().primaryColor(),
      //   dayPeriodTextColor: Constants().primaryColor(),
      //   dialHandColor: Constants().primaryColor(),
      // ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith((states) {
            return TextStyle(color: Constants().primaryColor());
          }),
          iconColor: MaterialStateProperty.resolveWith((states) {
            return Constants().primaryColor();
          }),
        ),
      ),
      useMaterial3: true);

  var darkThemeData = ThemeData(
      primaryColor: Constants().primaryColorDark(),
      textTheme: const TextTheme(labelLarge: TextStyle(color: Colors.black54)),
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        elevation: 0,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: Colors.lightBlueAccent,
      ),
      tabBarTheme: const TabBarTheme(labelColor: Colors.white),
      indicatorColor: Constants().primaryColorDark(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardTheme: CardTheme(
        elevation: 4,
        shadowColor: Constants().primaryColorDark(),
        surfaceTintColor: Constants().primaryColorDark(),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Constants().primaryColorDark(),
        selectedIconTheme: const IconThemeData(size: 32),
        selectedLabelStyle: const TextStyle(fontSize: 16),
        unselectedItemColor: Colors.white70,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Constants().primaryColor())),
      ),
      drawerTheme:
          DrawerThemeData(surfaceTintColor: Constants().primaryColor()),
      popupMenuTheme:
          PopupMenuThemeData(surfaceTintColor: Constants().primaryColor()),
      dialogTheme: DialogTheme(surfaceTintColor: Constants().primaryColor()),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          surfaceTintColor: MaterialStateProperty.resolveWith((states) {
            return Constants().primaryColor();
          }),
          textStyle: MaterialStateProperty.resolveWith((states) {
            return TextStyle(color: Constants().primaryColor());
          }),
        ),
      ),
      useMaterial3: true);
}
