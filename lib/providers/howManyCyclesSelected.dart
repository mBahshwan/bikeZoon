import 'package:flutter/material.dart';

class HowManyCycleSelectedAdult extends ChangeNotifier {
  int countAdultCycles = 0;

  void selectedAdultCycles(val) {
    countAdultCycles = val;
    notifyListeners();
  }
}

class HowManyCycleSelectedKidz extends ChangeNotifier {
  int countKidzCycles = 0;

  void selectedKidzCycles(val) {
    countKidzCycles = val;
    notifyListeners();
  }
}
