import 'dart:math';

import 'package:flutter/cupertino.dart';

class Linker{
  final Offset start;
  final Offset end;
  double? anchor;
  List<Linker> nodes = [];
  Linker? parent;

  Linker({
    this.start = Offset.zero,
    this.end = Offset.zero,
    this.anchor,
  });

  void appendByLength(double anchor, double length, double rad) {
    Offset start = Offset(
      (this.start.dx + this.end.dx)*anchor,
      (this.start.dy + this.end.dy)*anchor,
    );
    Offset end = start.translate(cos(rad)*length, sin(rad)*length);
    Linker node = Linker(start: start, end: end, anchor: anchor);
    node.parent = this;
    nodes.add(node);
  }

  void appendLinker(double anchor, Linker linker) {
    linker.anchor = anchor;
    linker.parent = this;
    nodes.add(linker);
  }
}
