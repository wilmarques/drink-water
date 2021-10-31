import 'package:shared_preferences/shared_preferences.dart';

class WaterIntakeStorage {
  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();

  Future<int> getWaterIntake() async {
    final preferences = await _preferences;

    final lastEditDay = await _getLastEditDate();
    final today = DateTime.now().day;
    if (lastEditDay == 0 || lastEditDay != today) {
      return 0;
    }

    return preferences.getInt('intake') ?? 0;
  }

  Future<bool> storeWaterIntake(int value) async {
    final preferences = await _preferences;
    _saveLastEditDate();
    return preferences.setInt('intake', value);
  }

  Future<int> _getLastEditDate() async {
    final preferences = await _preferences;
    return preferences.getInt('last_edit_date') ?? 0;
  }

  Future<bool> _saveLastEditDate() async {
    final todayDay = DateTime.now().day;
    final preferences = await _preferences;
    return preferences.setInt('last_edit_date', todayDay);
  }
}
