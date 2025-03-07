import 'package:shared_preferences/shared_preferences.dart';

Future<List<Map<String, String>>> getRecentLogins(
   ) async {
  final pref = await SharedPreferences.getInstance();
  List<String> logins = pref.getStringList('recentLogins') ?? [];

  return logins.map<Map<String, String>>((user) {
    final parts = user.split('|');
    if (parts.length == 2) {
      return {'email': parts[0], 'password': parts[1]};
    }
    return {};
  }).toList();
}


Future<void> saveLoginCredentials(String email, String password) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> logins = prefs.getStringList('recent_logins') ?? [];

  //? Checking if the email already exsits there 
  bool alreadyExists = logins.any((entry) => entry.split('|').first == email);

  if (!alreadyExists) {
    logins.add('$email|$password'); // Store as "email|password"
    await prefs.setStringList('recent_logins', logins);
  }
}

