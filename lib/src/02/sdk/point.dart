import 'package:flutter/cupertino.dart';

class Point{
  final double x;
  final double y;

  Point(this.x, this.y);

  void paint(Canvas canvas){
    Offset point = Offset(x, y);
    _paintPoint(canvas,point);
  }

  void _paintPoint(Canvas canvas,Offset point){
    Paint paint = Paint();
    canvas.drawCircle(point, 4, paint..style = PaintingStyle.stroke);
    canvas.drawCircle(point, 2, paint..style = PaintingStyle.fill);
  }

}