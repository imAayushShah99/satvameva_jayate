import 'package:shared_preferences/shared_preferences.dart';

class PrefServices {
  Future createCache(String email, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', email);
    preferences.setString('password', password);
  }

  Future readCache() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.getString('email');
    var a = preferences.getString('email');
    return a;
  }

  Future removeCache() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
  }
}
