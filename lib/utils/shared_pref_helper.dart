import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  Future<int> getVal(String dbKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? value = prefs.getInt(dbKey);
    return value ?? 0;
  }

  void updateVal(String dbKey, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(dbKey, value);
  }
}
