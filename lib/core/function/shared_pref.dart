import 'package:admin_dashboard/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<void> saveToken(String token) async {
    di<SharedPreferences>().setString('token', token);
  }

  static Future<String?> getToken() async {
    return di<SharedPreferences>().getString('token');
  }
}