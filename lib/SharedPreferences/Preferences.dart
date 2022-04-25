
import 'package:get/get.dart';
import 'package:physician/Views/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences
{
  static Future<void> setUser(String json)async
  {
    final pref=await SharedPreferences.getInstance();
    pref.setString("user", json);
  }

 static Future<String> getUser()async
  {
    final pref=await SharedPreferences.getInstance();
    String data=pref.getString("user") ?? '';
    return data;
  }
}