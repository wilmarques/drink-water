import 'package:hive/hive.dart';

class WaterIntakeStorage {
  late Box box;

  WaterIntakeStorage() {
    _initialize();
  }

  Future<void> _initialize() async {
    box = await Hive.openBox('water_intake');
  }

  Future<int> getWaterIntake() async {
    final lastEditDay = await _getLastEditDate();
    final today = DateTime.now().day;
    if (lastEditDay == 0 || lastEditDay != today) {
      storeWaterIntake(0);
      return 0;
    }

    final storedIntake = box.get('intake');
    return storedIntake ?? 0;
  }

  Future<void> storeWaterIntake(int value) async {
    _saveLastEditDate();
    return await box.put('intake', value);
  }

  Future<int> _getLastEditDate() async {
    return await box.get('last_edit_date') ?? 0;
  }

  Future<void> _saveLastEditDate() async {
    final todayDay = DateTime.now().day;
    return await box.put('last_edit_date', todayDay);
  }
}
