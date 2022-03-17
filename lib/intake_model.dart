import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class WaterIntakeRecordHiveAdapter extends HiveObject {

  @HiveField(0)
  late int amount;

  @HiveField(1)
  late int timestamp;
}
