import 'package:flutter/cupertino.dart';
import 'package:skeleton/src/arrow_path/arrow/port_path.dart';

class CustomPortPath extends PortPathBuilder{
  const CustomPortPath();

  @override
  Path fromPathByRect(Rect zone) {
    Path path = Path();
    Offset p0 = zone.centerLeft;
    Offset p1 = zone.bottomRight;
    Offset p2 = zone.topRight;
    path
      ..moveTo(p0.dx, p0.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..close();
    return path;
  }

  @override
  String get debugLabel => 'CustomPortPath';
}

class ThreeAnglePortPath extends PortPathBuilder{
  final double rate;

  const ThreeAnglePortPath({this.rate = 0.75});

  @override
  Path fromPathByRect(Rect zone) {
    Path path = Path();
    Offset p0 = zone.centerLeft;
    Offset p1 = zone.bottomRight.translate(0, -zone.height * 0);
    Offset p2 = zone.topRight.translate(0, zone.height * 0);
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
  String get debugLabel => 'ThreeAnglePortPath:rate=$rate';
}

class ThreeAngleStorkPortPath extends PortPathBuilder {
  final double rate;
  final double innerScale;

  const ThreeAngleStorkPortPath({this.rate = 0.8, this.innerScale = 0.5});

  @override
  Path fromPathByRect(Rect zone) {
    Path path = Path();
    Offset p0 = zone.centerLeft;
    Offset p1 = zone.bottomRight.translate(0, -zone.height * 0);
    Offset p2 = zone.topRight.translate(0, zone.height * 0);
    Offset p3 = p0.translate(rate * zone.width, 0);
    path
      ..moveTo(p0.dx, p0.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(p3.dx, p3.dy)
      ..lineTo(p2.dx, p2.dy)
      ..close();
    Path innerPath = path
        .transform(Matrix4.diagonal3Values(innerScale, innerScale, 1).storage);
    return Path.combine(PathOperation.difference, path, innerPath);
  }

  @override
  String get debugLabel =>
      'ThreeAngleStorkPortPath[rate=$rate,innerScale=$innerScale]';
}
