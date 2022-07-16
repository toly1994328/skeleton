import 'dart:math';

import 'package:flutter/material.dart';

abstract class PortPathBuilder{
  const PortPathBuilder();

  Path fromPathByRect(Rect zone);

  String get debugLabel;
}


class TrianglePortPath extends PortPathBuilder {
  final double rate;
  final double lowRate;

  const TrianglePortPath({this.rate = 0.75, this.lowRate = 0.15});

  const TrianglePortPath.custom()
      : rate = 1,
        lowRate = 0;

  const TrianglePortPath.customLow({this.lowRate=0.15})
      : rate = 1;

  const TrianglePortPath.threeAngle({this.rate = 0.75})
      : lowRate = 0;

  @override
  Path fromPathByRect(Rect zone) {
    Path path = Path();
    Offset p0 = zone.centerLeft;
    Offset p1 = zone.bottomRight.translate(0, -zone.height * lowRate);
    Offset p2 = zone.topRight.translate(0, zone.height * lowRate);
    Offset p3 = p0.translate(rate * zone.width, 0);
    path
      ..moveTo(p0.dx, p0.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(p3.dx, p3.dy)
      ..lineTo(p2.dx, p2.dy)
      ..close();
    return path;
  }

  @override
  String get debugLabel => 'TrianglePortPath:lowRate=$lowRate:rate:$rate';
}

class HalfTrianglePortPath extends PortPathBuilder {
  final double lineWidth;

  const HalfTrianglePortPath({required this.lineWidth});

  @override
  Path fromPathByRect(Rect zone) {
    Path path = Path();
    Offset p0 = zone.centerLeft.translate(0, lineWidth/2);
    Offset p1 = zone.centerRight.translate(0, lineWidth/2);
    Offset p2 = zone.topRight;
    path..moveTo(p0.dx, p0.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..close();
    return path;
  }

  @override
  String get debugLabel => 'HalfTrianglePortPath:lineWidth=$lineWidth';
}

class TriangleLinePortPath extends PortPathBuilder {
  final double lineWidth;
  final double lowRate;

  const TriangleLinePortPath({required this.lineWidth,this.lowRate=0});

  @override
  String get debugLabel => "TriangleLinePortPath:[lineWidth:$lineWidth,lowRate:$lowRate]";

  @override
  Path fromPathByRect(Rect zone) {
    Path path = Path();
    Offset p0 = zone.centerLeft;
    Offset p1 = zone.bottomRight.translate(0, -zone.height * lowRate);
    Offset p2 = zone.topRight.translate(0, zone.height * lowRate);
    double radBR = (p1-p0).direction;
    double c = zone.height/2-cos(radBR)*lineWidth-lineWidth/2-zone.height * lowRate;
    path..moveTo(p0.dx, p0.dy)
    ..lineTo(p1.dx, p1.dy)
    ..relativeLineTo(sin(radBR)*lineWidth, -cos(radBR)*lineWidth)
    ..relativeLineTo(-c/(tan(radBR)), -c)
    ..relativeLineTo((c)/(tan(radBR)), 0)
    ..relativeLineTo(0, -lineWidth)
    ..relativeLineTo(-(c)/(tan(radBR)), 0)
    ..relativeLineTo(c/(tan(radBR)), -c)
    ..lineTo(p2.dx, p2.dy)..close();
    return path;
  }
}

class HalfTriangleLinePortPath extends PortPathBuilder {
  final double lineWidth;


  const HalfTriangleLinePortPath({required this.lineWidth});

  @override
  String get debugLabel => "HalfTriangleLinePortPath:[lineWidth:$lineWidth]";

  @override
  Path fromPathByRect(Rect zone) {
    Path path = Path();
    Offset p0 = zone.centerLeft.translate(0, lineWidth/2);
    Offset p2 = zone.topRight;
    double radBR = (p2-p0).direction;
    double c = zone.height/2-cos(radBR)*lineWidth-lineWidth/2;
    path..moveTo(p0.dx, p0.dy)
      ..lineTo(p2.dx, p2.dy)
    ..relativeLineTo(-sin(radBR)*lineWidth, cos(radBR)*lineWidth)
    ..relativeLineTo(c/(tan(radBR)), c)
    ..relativeLineTo(-c/(tan(radBR)), 0)
    ..relativeLineTo(0, lineWidth)
    ..close();
    return path;
  }
}

class StokeHandler extends PortPathBuilder {
  final PortPathBuilder child;
  final double innerScale;

  StokeHandler({required this.child, this.innerScale = 0.5});

  @override
  String get debugLabel =>
      "StokeHandler[innerScale:$innerScale,child:${child.debugLabel}]";

  @override
  Path fromPathByRect(Rect zone) {
    Path outPath = child.fromPathByRect(zone);
    Offset p0 = zone.centerLeft;
    Offset p1 = zone.bottomRight.translate(0, -zone.height * 0.8);
    Offset p2 = zone.topRight.translate(0, zone.height * 0.8);
    // Offset origin =

    double x1 = p0.dx;
    double y1 = p0.dy;

    double x2 = p1.dx;
    double y2 = p1.dy;

    double x3 = p2.dx;
    double y3 = p2.dy;

    double a1 = 2 * (x2 - x1);
    double b1 = 2 * (y2 - y1);
    double c1 = x2 * x2 + y2 * y2 - x1 * x1 - y1 * y1;
    double a2 = 2 * (x3 - x2);
    double b2 = 2 * (y3 - y2);
    double c2 = x3 * x3 + y3 * y3 - x2 * x2 - y2 * y2;
    double x = ((c1 * b2) - (c2 * b1)) / ((a1 * b2) - (a2 * b1));
    double y = ((a1 * c2) - (a2 * c1)) / ((a1 * b2) - (a2 * b1));
    print("$x,$y");
    print("${150 * 0.15}");

    double offset = 150 * 0.15;
    Matrix4 m4 = Matrix4.translationValues(x, y, 0);
    m4.multiply(Matrix4.diagonal3Values(innerScale, innerScale, 1));
    m4.multiply(Matrix4.translationValues(-x, y, 0));
    Path innerPath = outPath.transform(m4.storage);
    return Path.combine(PathOperation.difference, outPath, innerPath);
  }
}


class CirclePortPath extends PortPathBuilder {
  const CirclePortPath();

  @override
  Path fromPathByRect(Rect zone) {
    Path path = Path();
    path.addOval(zone);
    return path;
  }

  @override
  String get debugLabel => 'CirclePortPath';
}