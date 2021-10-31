import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class WaterIntakeModel extends ChangeNotifier {
  int current = 0;

  int increment(int ammount) {
    return current += ammount;
  }

  int decrease(int ammout) {
    return current -= ammout;
  }
}
