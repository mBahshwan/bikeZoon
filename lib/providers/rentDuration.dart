import 'package:flutter/material.dart';

class RentDuration extends ChangeNotifier {
  Object? howLong;

  changeDuration(val) {
    howLong = val;
    notifyListeners();
  }
}
