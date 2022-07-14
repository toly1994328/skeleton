import 'package:flutter/material.dart';

abstract class PortPathBuilder{
  const PortPathBuilder();
  Path fromPathByRect(Rect zone);
}

class CustomPortPath extends PortPathBuilder{
  const CustomPortPath();

  @override
  Path fromPathByRect(Rect zone) {
    Path path = Path();
    Offset p0 = zone.centerLeft;
    Offset p1 = zone.bottomRight;
    Offset p2 = zone.topRight;
    path..moveTo(p0.dx, p0.dy)..lineTo(p1.dx, p1.dy)..lineTo(p2.dx, p2.dy)..close();
    return path;
  }
}

class ThreeAnglePortPath extends PortPathBuilder{
  final double rate;

  const ThreeAnglePortPath({this.rate = 0.8});

  @override
  Path fromPathByRect(Rect zone) {
    Path path = Path();
    Offset p0 = zone.centerLeft;
    Offset p1 = zone.bottomRight;
    Offset p2 = zone.topRight;
    Offset p3 = p0.translate(rate * zone.width, 0);
    path
      ..moveTo(p0.dx, p0.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(p3.dx, p3.dy)
      ..lineTo(p2.dx, p2.dy)
      ..close();
    return path;
  }
}

class CirclePortPath extends PortPathBuilder{

  const CirclePortPath();

  @override
  Path fromPathByRect(Rect zone) {
    Path path = Path();
    path.addOval(zone);
    return path;
  }
}