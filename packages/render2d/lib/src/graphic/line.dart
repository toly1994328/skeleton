import 'dart:math';
import 'dart:ui';
import 'path_builder.dart';

///
/// 圆
///


class LineShape extends Shape {
  double x1 = 0;
  double x2 = 0;
  double y2 = 0;
  double y1 = 0;

  LineShape({
    this.x1 = 0,
    this.x2 = 0,
    this.y1 = 0,
    this.y2 = 0,
  });

  @override
  String toString() {
    return 'LineShape{x1: $x1, x2: $x2, y2: $y2, y1: $y1}';
  }
}

class Line extends PathBuilder {
  LineShape shape;

  Line(this.shape);

  @override
  Path builder() {
    Path path = Path();
    path.moveTo(shape.x1, shape.y1);
    path.lineTo(shape.x2, shape.y2);
    return path;
  }
}
