import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


class Session {
  static final Session shared = Session();

  User current;

  Session([this.current]);

  setCurrent(User user) { this.current = user; }

  User getCurrent() => this.current;

  Future<bool> emptySession() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiKey = await prefs.get("localKey");

    if (apiKey == null || apiKey.isEmpty || apiKey.length == 0) {
      return true;
    }

    await prefs.remove("localKey");

    current = null;

    return true;
  }

  isEmpty() => current == null;

  static Future<bool> loadStoredSession() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiKey = await prefs.get("localKey");

    if (apiKey == null || apiKey.isEmpty || apiKey.length == 0) {
      return false;
    }

    User user = User(apiKey: apiKey, email: "", name: "");
    shared.setCurrent(user);

    return true;
  }

}