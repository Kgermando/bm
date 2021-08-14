import 'dart:convert';
import 'package:e_management/src/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static const _keyUser = 'jwt';


  static Future<User> read() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_keyUser);

    // print("Json $json");

    User user = User.fromJson(jsonDecode(json!));

    // print("User $user");

    return user;
  }

  static save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
