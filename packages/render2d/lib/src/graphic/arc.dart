import 'dart:math';
import 'dart:ui';

import 'path_builder.dart';

///
/// 圆弧
///

class ArcShape extends Shape {
  double cx;
  double cy;
  double r;
  double startAngle;
  double endAngle;
  bool clockwise;

  ArcShape({
    this.cx = 0,
    this.cy = 0,
    this.r = 0,
    this.startAngle = 0,
    this.endAngle = pi * 2,
    this.clockwise = true,
  });
}

class Arc extends PathBuilder {
  ArcShape shape;

  Arc(this.shape);

  @override
  Path builder() {
    double x = shape.cx;
    double y = shape.cy;
    double r = max(shape.r, 0);
    double startAngle = shape.startAngle;
    double endAngle = shape.endAngle;
    bool clockwise = shape.clockwise;
    double unitX = cos(startAngle);
    double unitY = sin(startAngle);
    Path path = Path();
    path.moveTo(unitX * r + x, unitY * r + y);
    Rect rect = Rect.fromCircle(
      center: Offset(x, y),
      radius: r,
    );
    double sweep = endAngle - startAngle;
    if(!clockwise){
      sweep = -(pi*2-sweep);
    }
    path.arcTo(rect, startAngle, sweep, false);
    return path;
  }
}
