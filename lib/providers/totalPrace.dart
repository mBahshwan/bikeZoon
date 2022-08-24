import 'package:flutter/material.dart';

class TotalPrice extends ChangeNotifier {
  int kidzPrice = 0;
  int adultPrice = 0;
  int totalPrice = 0;
  getTotal() {
    totalPrice = kidzPrice + adultPrice;
    notifyListeners();
  }
}
