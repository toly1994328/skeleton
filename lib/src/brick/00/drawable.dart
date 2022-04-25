import 'dart:ui';

import 'package:flutter/material.dart';

abstract class Drawable {
  Offset offset;

  Drawable(this.offset);

  void paint(Canvas canvas);
}

class Ball {
  double x; // x 位移.

  double y; // y 位移.

  double vx; // 粒子水平速度.

  double ax; // 粒子水平加速度

  double ay; // 粒子竖直加速度

  double vy;

  ///粒子竖直速度.

  double size;

  /// 粒子大小.

  Color color;

  /// 粒子颜色.

  Ball({
    this.x = 0,
    this.y = 0,
    this.ax = 0,
    this.ay = 0,
    this.vx = 0,
    this.vy = 0,
    this.size = 0,
    this.color = Colors.blue,
  });

  void paint(Canvas canvas, Paint paint) {
    paint.color = color;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(x , y), size, paint);
  }

  void runInBox(Rect limit){
    limit = limit.deflate(size);
    x += vx;
    y += vy;
    if (x > limit.right) {
      x = limit.right;
      vx = -vx;
    }
    if (x < limit.left) {
      x = limit.top;
      vx = -vx;
    }
    if (y > limit.bottom) {
      y = limit.bottom;
      vy = -vy;
    }
    if (y < limit.top) {
      y = limit.top;
      vy = -vy;
    }
    print('runInBox===($x,$y)');

  }

  void animate(double distance) {


    // double t = distance/vx;
    // double disX = distance+x;


    // if (x < offset.dx) {
    //   x += vx;
    // }
    // if (x > vx) {
    //   x += vx;
    // }
  }
}
