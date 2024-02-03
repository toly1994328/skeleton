import 'dart:math';
import 'dart:ui';
import 'path_builder.dart';

///
/// 圆
///


class RingShape extends Shape {
  double cx = 0;
  double cy = 0;
  double r = 0;
  double r0 = 0;

  RingShape({
    this.cx = 0,
    this.cy = 0,
    this.r = 0,
    this.r0 = 0,
  });

  @override
  String toString() {
    return 'RingShape{cx: $cx, cy: $cy, r: $r}';
  }

}

class Ring extends PathBuilder {
  RingShape shape;

  Ring(this.shape);

  @override
  Path builder() {

    Rect rect = Rect.fromCircle(
      center: Offset(shape.cx, shape.cy),
      radius: shape.r,
    );

    Rect rect0 = Rect.fromCircle(
      center: Offset(shape.cx, shape.cy),
      radius: shape.r0,
    );

    Path path = Path();

    path.arcTo(rect, 0, pi, false);
    path.arcTo(rect, pi, pi, false);

    path..moveTo(shape.cx+shape.r0, shape.cy);
    path.arcTo(rect0, 0, -pi, false);
    path.arcTo(rect0, -pi, -pi, false);

    // const x = shape.cx;
    // const y = shape.cy;
    // const PI2 = Math.PI * 2;
    // ctx.moveTo(x + shape.r, y);
    // ctx.arc(x, y, shape.r, 0, PI2, false);
    // ctx.moveTo(x + shape.r0, y);
    // ctx.arc(x, y, shape.r0, 0, PI2, true);

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
