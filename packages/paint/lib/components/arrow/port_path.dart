import 'dart:math';

import 'package:flutter/material.dart';

abstract class PortPathBuilder{
  const PortPathBuilder();

  Path fromPathByRect(Rect zone);

  String get debugLabel;
}


class TrianglePortPath extends PortPathBuilder with StokePathMixin{
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


  @override
  StokeConfig calculateConfig(Rect zone, double lineWidth) {
    Offset p0 = zone.centerLeft;
    Offset p1 = zone.bottomRight;
    double rad = (p1-p0).direction;
    double offsetX = lineWidth/sin(rad);
    double shapeWidth = zone.width-(1-this.rate) * zone.width;
    double offsetEnd = lineWidth;
    double rate = (shapeWidth-offsetX-offsetEnd)/(shapeWidth);
    return StokeConfig(offsetX: offsetX, rate: rate);
  }
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

mixin StokePathMixin on PortPathBuilder{
  StokeConfig calculateConfig(Rect zone,double lineWidth);
}

class StokeConfig{
  final double offsetX;
  final double rate;

  StokeConfig({required this.offsetX,required this.rate});
}

class StokeHandler extends PortPathBuilder {
  final StokePathMixin child;
  final double lineWidth;

  StokeHandler({required this.child, required this.lineWidth});

  @override
  Path fromPathByRect(Rect zone) {
    Path outPath = child.fromPathByRect(zone);
    Matrix4 m4 = Matrix4.identity();
    StokeConfig config = child.calculateConfig(zone, lineWidth);
    double centerX = -zone.size.width/2+config.offsetX;
    double rate = config.rate;
    m4.multiply(Matrix4.translationValues(centerX, 0, 0));
    m4.multiply(Matrix4.diagonal3Values(rate, rate, 1));
    m4.multiply(Matrix4.translationValues(-centerX, 0, 0));
    m4.multiply(Matrix4.translationValues(config.offsetX, 0, 0));

    Path innerPath = outPath.transform(m4.storage);
    return Path.combine(PathOperation.difference, outPath, innerPath);
  }

  @override
  String get debugLabel =>
      "StokeHandler[lineWidth:$lineWidth,child:${child.debugLabel}]";
}

class CirclePortPath extends PortPathBuilder with StokePathMixin{
  const CirclePortPath();

  @override
  Path fromPathByRect(Rect zone) {
    Path path = Path();
    path.addOval(zone);
    return path;
  }

  @override
  String get debugLabel => 'CirclePortPath';

  @override
  StokeConfig calculateConfig(Rect zone, double lineWidth) {
    return StokeConfig(offsetX: lineWidth, rate: (zone.width-lineWidth*2)/zone.width);
  }
}

class RhombusPortPath extends PortPathBuilder with StokePathMixin{
  final double lowRate;

  const RhombusPortPath({this.lowRate=0});

  @override
  Path fromPathByRect(Rect zone) {
    Path path = Path();
    Offset p0 = zone.centerLeft;
    Offset p1 = zone.bottomCenter.translate(0, -zone.height*lowRate);
    Offset p2 = zone.centerRight;
    Offset p3 = zone.topCenter.translate(0, zone.height*lowRate);
    path..moveTo(p0.dx, p0.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..lineTo(p3.dx, p3.dy)
      ..close();
    return path;
  }

  @override
  String get debugLabel => 'RhombusPortPath[lowRate:$lowRate]';

  @override
  StokeConfig calculateConfig(Rect zone, double lineWidth) {
    Offset p0 = zone.centerLeft;
    Offset p1 = zone.bottomCenter;
    double rad = (p1-p0).direction;
    double offsetX = lineWidth/sin(rad);
    double shapeWidth = zone.width;
    double offsetEnd = offsetX;
    double rate = (shapeWidth-offsetX-offsetEnd)/(shapeWidth);
    return StokeConfig(offsetX: offsetX, rate: rate);
  }
}