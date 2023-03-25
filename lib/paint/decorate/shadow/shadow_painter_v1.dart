import 'dart:math';

import 'package:flutter/material.dart';

class ShadowPainterV1 extends CustomPainter{

  final Paint _mainPainter = Paint()
    ..color = const Color(0xff292869)
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Rect.fromPoints(
          Offset.zero,
          const Offset(100,60),
        ), const Radius.circular(8)),
      );
    canvas.translate(-250, 0);
    drawBox(canvas,2,);
    canvas.translate(150, 0);
    drawBox(canvas,5,);
    canvas.translate(150, 0);
    drawBox(canvas,6,);
    canvas.translate(150, 0);
    drawBox(canvas,9,);
    canvas.translate(150, 0);
  }

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  void drawBox(Canvas canvas,double elevation){
    Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Rect.fromPoints(
          Offset.zero,
          const Offset(100,60),
        ), const Radius.circular(8)),
      );
    canvas.drawShadow(path, Colors.blue.withOpacity(0.2), elevation, false);
    Paint whitePaint =  Paint()..color=Colors.white;
    canvas.drawPath(path,whitePaint);

    textPainter.text = TextSpan(
        text: 'elevation: $elevation',
        style:  const TextStyle(fontSize: 12, color: Colors.black));
    textPainter.layout(); // 进行布局
    textPainter.paint(canvas, Offset(10,-30));

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}