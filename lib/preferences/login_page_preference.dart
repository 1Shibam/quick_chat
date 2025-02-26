import 'package:shared_preferences/shared_preferences.dart';

Future<void> setLoginPreference(bool set) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', set);
}
