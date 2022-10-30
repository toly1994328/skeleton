import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:skeleton/src/sector/selectable.dart';

class SectorTween extends Tween<SectorShape>{
  SectorTween({ super.begin, super.end });

  @override
  SectorShape lerp(double t) => SectorShape.lerp(begin!, end!, t);
}

class SectorShape extends Selectable{
  Offset center; // 中心点
  double innerRadius; // 小圆半径
  double outRadius; // 大圆半径
  double startAngle; // 起始弧度
  double sweepAngle; // 扫描弧度

  SectorShape({
    required this.center,
    required this.innerRadius,
    required this.outRadius,
    required this.startAngle,
    required this.sweepAngle,
  });

  SectorShape copyWith({
    Offset? center,
    double? innerRadius,
    double? outRadius,
    double? startAngle,
    double? sweepAngle,
}){
    return SectorShape(
        center:center??this.center,
        innerRadius:innerRadius??this.innerRadius,
        outRadius:outRadius??this.outRadius,
        startAngle:startAngle??this.startAngle,
        sweepAngle:sweepAngle??this.sweepAngle,
    );
  }

  @override
  bool contains(Offset p) {
    Offset position = p - center;
    // 校验环形区域
    double l = position.distance;
    bool inRing = l <= outRadius && l >= innerRadius;
    if (!inRing) return false;

    // 校验角度范围
    double a = position.direction;
    double endArg = startAngle + sweepAngle;
    double start = startAngle;
    if(sweepAngle>0){
      if(position.dx<0&&position.dy<0){
        a+=2*pi;
      }
      return a >= start && a <= endArg;
    }else{
      return a <= start && a >= endArg;
    }
  }

  Path formPath() {
    double startRad = startAngle;
    double endRad = startAngle + sweepAngle;
    double r0 = innerRadius;
    double r1 = outRadius;
    Offset p0 = Offset(cos(startRad) * r0, sin(startRad) * r0);
    Offset p1 = Offset(cos(startRad) * r1, sin(startRad) * r1);
    Offset q0 = Offset(cos(endRad) * r0, sin(endRad) * r0);
    Offset q1 = Offset(cos(endRad) * r1, sin(endRad) * r1);
    bool large = sweepAngle.abs() > pi;
    bool clockwise = sweepAngle > 0;
   Path path = Path()
      ..moveTo(p0.dx, p0.dy)
      ..lineTo(p1.dx, p1.dy)
      ..arcToPoint(q1, radius: Radius.circular(r1), clockwise: clockwise, largeArc: large)
      ..lineTo(q0.dx, q0.dy)
      ..arcToPoint(p0, radius: Radius.circular(r0), clockwise: !clockwise, largeArc: large);
    return path.shift(center);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectorShape &&
          runtimeType == other.runtimeType &&
          center == other.center &&
          innerRadius == other.innerRadius &&
          outRadius == other.outRadius &&
          startAngle == other.startAngle &&
          selected == other.selected &&
          sweepAngle == other.sweepAngle;

  @override
  int get hashCode =>
      center.hashCode ^
      innerRadius.hashCode ^
      outRadius.hashCode ^
      startAngle.hashCode ^
      selected.hashCode ^
      sweepAngle.hashCode;

  static SectorShape lerp(SectorShape begin, SectorShape end, double t) {
        return SectorShape(
            center: begin.center,
            innerRadius:begin.innerRadius,
            outRadius: begin.outRadius,
            startAngle: _lerpDouble(begin.startAngle,end.startAngle,t),
            sweepAngle: _lerpDouble(begin.sweepAngle,end.sweepAngle,t),
        );
  }

  static double _lerpDouble(double a, double b, double t) {
    return a * (1.0 - t) + b * t;
  }
}
