import 'package:shared_preferences/shared_preferences.dart';

Future<void> setOnBoardingStatus(bool set) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('hasSeenOnBoarding', set);
}
