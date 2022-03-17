import 'package:flutter/foundation.dart';

import 'water_intake_storage.dart';

class WaterIntake extends ChangeNotifier {
  int _current = 0;
  late WaterIntakeStorage storage;

  int get current {
    _current = storage.getWaterIntake();
    return _current;
  }

  WaterIntake() {
    _initializeData();
  }

  void _initializeData() async {
    storage = WaterIntakeStorage();
    _current = storage.getWaterIntake();
    notifyListeners();
  }

  void increment({int amount = 100}) {
    _current += amount;
    _storeAndNotify(_current);
  }

  void decrease({int amount = 100}) {
    if (_current < amount) {
      _current = 0;
    } else {
      _current -= amount;
    }
    _storeAndNotify(_current);
  }

  void _storeAndNotify(int value) {
    storage.storeWaterIntake(value);
    notifyListeners();
  }
}
