import 'package:flutter/material.dart';

typedef Fx = double Function(double x);

class Fun {
  final String name;
  final int pointCount;
  final Color color;
  final double strokeWidth;
  final Fx fx;

  Fun({
    this.name = '',
    required this.fx,
    this.pointCount = 200,
    this.color = Colors.blue,
    this.strokeWidth = 1,
  });
}
