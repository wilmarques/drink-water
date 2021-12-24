import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {

  static String waterIntakeBoxName = 'water_intake';

  static start() async {
    await Hive.initFlutter();
    await Hive.openBox(waterIntakeBoxName);
  }
}
