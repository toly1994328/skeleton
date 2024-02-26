import 'dart:math';
import 'dart:ui';
import 'path_builder.dart';

///
/// 圆
///

class CircleShape extends Shape {
  double cx = 0;
  double cy = 0;
  double r = 0;

  CircleShape({
    this.cx = 0,
    this.cy = 0,
    this.r = 0,
  });

  @override
  String toString() {
    return 'CircleShape{cx: $cx, cy: $cy, r: $r}';
  }
}

class Circle extends PathBuilder {
  CircleShape shape;

  Circle(this.shape);

  @override
  Path builder() {
    Rect rect = Rect.fromCircle(
      center: Offset(shape.cx, shape.cy),
      radius: shape.r,
    );
    Path path = Path();
    path.arcTo(rect, 0, pi, false);
    path.arcTo(rect, pi, pi, false);
    // path.arcToPoint(
    //   Offset(shape.cx, shape.cy), // 终点
    //   radius: Radius.elliptical(shape.r, shape.r),// 圆弧长短半轴
    //   rotation: 0, // 圆弧旋转角度
    //   largeArc: false, // 是否是大圆弧
    //   clockwise: true, // 是否是顺时针
    // );
    // path.arcToPoint(
    //   Offset.zero, // 终点
    //   radius: Radius.elliptical(shape.r, shape.r),// 圆弧长短半轴
    //   rotation: 0, // 圆弧旋转角度
    //   largeArc: false, // 是否是大圆弧
    //   clockwise: true, // 是否是顺时针
    // );
    return path;
  }
}
