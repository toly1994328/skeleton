import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skeleton/paint/coo/models/axis_range.dart';

import 'coordinate.dart';
import '../models/point_values.dart';

typedef Fx = double Function(double x);

class PainterBox extends CustomPainter {
  final Paint _bgPainter = Paint()..color = Colors.grey.withOpacity(0.1);
  final Paint _mainPainter = Paint()..color = Colors.blue;

  final Coordinate coordinate;

  final PointValues points;

  PainterBox(this.points,{required this.coordinate}) : super(repaint: points);

  @override
  void paint(Canvas canvas, Size size) {

    canvas.translate(0, size.height);
    coordinate.paint(canvas, size);
    canvas.scale(1, -1);
    // _drawPoint( canvas,  size);
    _drawFn(canvas,size);
  }

  void _drawPoint(Canvas canvas, Size size){
    Offset p = const Offset(0.6, 0.6);
    double x = (p.dx - coordinate.range.minX)/coordinate.range.xSpan*size.width;
    double y = (p.dy - coordinate.range.minY)/coordinate.range.ySpan*size.height;
    canvas.drawCircle(Offset(x, y), 10, _mainPainter);
  }

  void _drawFn(Canvas canvas, Size size,){
    List<Offset> points = [];
    int pointCount = 500;
    double step = coordinate.range.xSpan/pointCount;

    for(int i =0;i<pointCount;i++){
      double dx = coordinate.range.minX+step*i;
      double dy = 0.6*sin(dx*5);
      double x = (dx - coordinate.range.minX)/coordinate.range.xSpan*size.width;
      double y = (dy - coordinate.range.minY)/coordinate.range.ySpan*size.height;
      points.add(Offset(x, y));
    }

    List<Offset> points2 = [];
    for(int i =0;i<pointCount;i++){
      double dx = coordinate.range.minX+step*i;
      double dy = dx;
      double x = (dx - coordinate.range.minX)/coordinate.range.xSpan*size.width;
      double y = (dy - coordinate.range.minY)/coordinate.range.ySpan*size.height;
      points2.add(Offset(x, y));
    }

    List<Offset> points3 = [];
    for(int i =0;i<pointCount;i++){
      double dx = coordinate.range.minX+step*i;
      double dy = dx*dx*dx/20;
      double x = (dx - coordinate.range.minX)/coordinate.range.xSpan*size.width;
      double y = (dy - coordinate.range.minY)/coordinate.range.ySpan*size.height;
      points3.add(Offset(x, y));
    }

    canvas.drawPoints(PointMode.polygon, points, _mainPainter..color=Colors.blue);
    canvas.drawPoints(PointMode.polygon, points2, _mainPainter..color=Colors.red);
    canvas.drawPoints(PointMode.polygon, points3, _mainPainter..color=Colors.purple);
  }

  @override
  bool shouldRepaint(covariant PainterBox oldDelegate) {
    return oldDelegate.points != points;
  }
}
