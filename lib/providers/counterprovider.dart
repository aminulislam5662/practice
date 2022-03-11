import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count = 0;
  Color whitecolor = Colors.white;
  Color blackcolor = Colors.black;

  int get count => _count;

  void icrementcount() {
    _count++;
    print(_count);
    notifyListeners();
  }

  void color1(bool white) {
    if (white) {}
  }

  void decrementcount() {
    _count--;
    notifyListeners();
  }

  void resetcount() {
    _count = 0;
    notifyListeners();
  }
}
