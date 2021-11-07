import 'package:flutter/foundation.dart';

import 'water_intake_storage.dart';

class WaterIntake extends ChangeNotifier {
  late int _current;
  WaterIntakeStorage storage = WaterIntakeStorage();

  int get current => _current;

  WaterIntake() {
    _initializeData();
  }

  void _initializeData() async {
    _current = await storage.getWaterIntake();
    notifyListeners();
  }

  void increment({int ammount = 100}) {
    _current += ammount;
    _storeAndNotify(_current);
  }

  void decrease({int ammount = 100}) {
    if (_current < ammount) {
      _current = 0;
    } else {
      _current -= ammount;
    }
    _storeAndNotify(_current);
  }

  void _storeAndNotify(int value) {
    storage.storeWaterIntake(value);
    notifyListeners();
  }
}
