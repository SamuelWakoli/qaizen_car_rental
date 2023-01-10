import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //keys
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String themeKey = "THEMEKEY";

  // saving the data to SharedPref

  static Future<bool> saveUserLoggedInStatus(bool isUserSignedIn) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return await sharedPref.setBool(userLoggedInKey, isUserSignedIn);
  }

  static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return await sharedPref.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return await sharedPref.setString(userEmailKey, userEmail);
  }

  // getting the data from SF

  static Future<bool?> getUserSignedInStatus() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(userEmailKey);
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(userNameKey);
  }

  static Future<bool?> getThemeSwitchStatus() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    int? result = sharedPref.getInt('selectedThemeId');
    if (result == 0) {
      return false;
    } else {
      return true;
    }
  }
}
