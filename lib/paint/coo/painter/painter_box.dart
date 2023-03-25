import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skeleton/paint/coo/models/axis_range.dart';

import 'coordinate.dart';
import '../models/point_values.dart';
import 'function_manager.dart';

typedef Fx = double Function(double x);

class PainterBox extends CustomPainter {
  final Paint _bgPainter = Paint()..color = Colors.grey.withOpacity(0.1);
  final Paint _mainPainter = Paint()..color = Colors.blue;

  final Coordinate coordinate;
  final FunctionManager fm;
  final PointValues points;

  PainterBox(this.points, {required this.coordinate,required this.fm}) : super(repaint: points);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    coordinate.paint(canvas, size);
    canvas.scale(1, -1);
    canvas.clipRect(Offset.zero & size);

    coordinate.drawAxisLine(canvas, size);
    fm.draw(canvas, size, coordinate);
  }

  @override
  bool shouldRepaint(covariant PainterBox oldDelegate) {
    return oldDelegate.points != points;
  }
}
