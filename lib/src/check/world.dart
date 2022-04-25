import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawable.dart';

class WorldRender extends ChangeNotifier implements CustomPainter {
  Size _size = Size.zero;

  Size get size => _size;

  Ball ball = Ball(size: 0);

  set size(Size value) {
    if (size == value) {
      return;
    }
    _size = value;
    ball = Ball(size: 20, vx: 2, vy: -2,x: value.width/2,y: value.height-20);
    notifyListeners();
  }

  @override
  bool? hitTest(Offset position) => null;

  final Paint _helpPaint = Paint();
  final Paint _mainPainter = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, _helpPaint..color = Colors.black);
    ball.paint(canvas, _mainPainter);
    canvas.translate(size.width/2, size.height/2);
    double width = 100;
    double height = 30;
    double radius = 10;
    var rect = Offset.zero & Size(width,height);
    // canvas.drawRect(rect, _helpPaint..color = Colors.green);
    Path path = Path()..addRect(rect);
    PathMetrics metrics = path.computeMetrics();
    for (var pm in metrics) {
      for(int i=0;i<20;i++){
        Tangent? tangent = pm.getTangentForOffset(pm.length * 1/20*i);
        if(tangent ==null) return;
        var dx = cos(tangent.angle*180/pi)*-radius;
        var dy = sin(tangent.angle*180/pi)*-radius;
        print(dx);
        print(dy);
        Offset center = tangent.position.translate(dy, dx);
        canvas.drawCircle(center, radius, _helpPaint..color=Colors.blue);
        canvas.drawCircle(center, 1, _helpPaint..color=Colors.white);
      }


      // element.
    }
    canvas.drawPath(path, _helpPaint..color = Colors.green);
  }

  @override
  SemanticsBuilderCallback? get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) =>
      shouldRepaint(oldDelegate);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  //

  void updateBall({Rect? rect}) {
    rect ??= Offset.zero & size;
    ball.runInBox(rect);
    notifyListeners();
  }

//
// WorldRender():super(repaint: controller);
//
// @override
// void paint(Canvas canvas, Size size) {
//   print(size);
//   canvas.drawRect(
//       Offset.zero & size,
//       _helpPaint
//         ..color = Colors.black);
//
//
//   ball.paint(canvas, _mainPainter);
//
// }
//
// @override
// bool shouldRepaint(covariant WorldRender oldDelegate) {
//   return true;
// }
}
