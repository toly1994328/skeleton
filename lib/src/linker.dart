import 'dart:math';

import 'package:flutter/cupertino.dart';

class Linker with ChangeNotifier {
  Offset start;
  Offset end;
  double? anchor;
  List<Linker> nodes = [];

  Linker({
    this.start = Offset.zero,
    this.end = Offset.zero,
    this.anchor,
  });

  void updateNodeAnchor(int index, double anchor) {
    if (nodes.length > index) {
      Linker node = nodes[0];
      Offset start = Offset(
        (this.start.dx + this.end.dx) * anchor,
        (this.start.dy + this.end.dy) * anchor,
      );
      node.end = start.translate(
          cos(node.rad) * node.length, sin(node.rad) * node.length);
      notifyListeners();
    }
  }

  double get length => (start - end).distance;

  double get rad => (start - end).direction;

  void appendByLength(double anchor, double length, double rad) {
    Offset start = Offset(
      (this.start.dx + this.end.dx) * anchor,
      (this.start.dy + this.end.dy) * anchor,
    );
    Offset end = start.translate(cos(rad) * length, sin(rad) * length);
    Linker node = Linker(start: start, end: end, anchor: anchor);
    nodes.add(node);
  }

  void appendLinker(double anchor, Linker linker) {
    linker.anchor = anchor;
    nodes.add(linker);
  }
}
