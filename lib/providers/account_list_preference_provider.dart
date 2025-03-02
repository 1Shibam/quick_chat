import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountListPreferenceNotifier extends StateNotifier<List<String>> {
  AccountListPreferenceNotifier() : super([]);

  Future<void> saveAccountList() async {}
}
