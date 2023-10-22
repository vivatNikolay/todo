import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthService {

  static Future<bool> isHasPass() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password') != null;
  }

  static Future<bool> createPass(String pass) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('password', pass);
  }

  static Future<bool> authenticate(String pass) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return pass == prefs.getString('password');
  }
}