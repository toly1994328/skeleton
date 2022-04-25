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
    canvas.drawRect(Offset.zero & Size(100,30), _helpPaint..color = Colors.green);

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
