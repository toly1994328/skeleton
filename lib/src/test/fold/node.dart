import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'line.dart';

class Node with ChangeNotifier{


  List<Line> lines = [];


  void paint(Canvas canvas) {
    for (Line line in lines) {
      line.paint(canvas);
    }
  }

  void addLine(Line line) {
    lines.add(line);
    notifyListeners();
  }



  void tick() {
    notifyListeners();
  }

  void rotate(double rotate, { Offset? centre}) {
    lines.first.rotate(rotate);
    notifyListeners();
  }

}