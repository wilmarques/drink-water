import 'package:hive/hive.dart';

import 'configs/hive_config.dart';

class WaterIntakeStorage {
  late final Box box;

  WaterIntakeStorage() {
    box = Hive.box(HiveConfig.waterIntakeBoxName);
  }

  int getWaterIntake() {
    final lastEditDay = _getLastEditDate();
    final today = DateTime.now().day;
    if (lastEditDay == 0 || lastEditDay != today) {
      storeWaterIntake(0);
      return 0;
    }

    return box.get('intake', defaultValue: 0);
  }

  Future<void> storeWaterIntake(int value) async {
    _saveLastEditDate();
    return await box.put('intake', value);
  }

  int _getLastEditDate() {
    return box.get('last_edit_date', defaultValue: 0);
  }

  Future<void> _saveLastEditDate() async {
    final todayDay = DateTime.now().day;
    return await box.put('last_edit_date', todayDay);
  }
}
