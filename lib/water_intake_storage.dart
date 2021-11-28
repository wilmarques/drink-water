// import 'package:hive/hive.dart';

class WaterIntakeStorage {
  // late Box box;

  WaterIntakeStorage() {
    _initialize();
  }

  Future<void> _initialize() async {
    // box = await Hive.openBox('water_intake');
  }

  int getWaterIntake() {
    final lastEditDay = _getLastEditDate();
    final today = DateTime.now().day;
    if (lastEditDay == 0 || lastEditDay != today) {
      storeWaterIntake(0);
      return 0;
    }

    // return box.get('intake', defaultValue: 0);
    return 0;
  }

  Future<void> storeWaterIntake(int value) async {
    _saveLastEditDate();
    // return await box.put('intake', value);
    return Future.value();
  }

  int _getLastEditDate() {
    // return box.get('last_edit_date', defaultValue: 0);
    return 16;
  }

  Future<void> _saveLastEditDate() async {
    final todayDay = DateTime.now().day;
    // return await box.put('last_edit_date', todayDay);
    return Future.value();
  }
}
