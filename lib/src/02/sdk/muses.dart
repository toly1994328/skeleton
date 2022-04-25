// 缪斯 - 希腊神话中主司艺术与科学的九位古老文艺女神的总称
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'line.dart';

class Muses {
  Paint paint = Paint();
  late Canvas canvas;
  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  void attach(Canvas canvas) {
    this.canvas = canvas;
  }

  void markAngle(
    Line line,
    double angle, {
    String? text,
    Color textColor = Colors.lightBlue,
  }) {
    paint
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    if(angle==90){
      canvas.save();
      canvas.translate(line.start.dx, line.start.dy);
      canvas.rotate(line.rad-pi/2);
      canvas.translate(-line.start.dx, -line.start.dy);
      canvas.drawRect(Rect.fromPoints(line.start,line.start+Offset(8,8)),paint);
      canvas.restore();
      return;
    }
    canvas.drawArc(Rect.fromCenter(center: line.start, width: 20, height: 20),
        line.rad, -angle / 180 * pi, false, paint);

    // if (text != null) {
    //   _drawHelpText(text, canvas, line.start.translate(0, 0),
    //       color: textColor);
    // }
  }

  void markLine(
    Line line, {
    Color color = Colors.black,
    String? start,
    String? end,
    Color textColor = Colors.lightBlue,
  }) {
    paint.color = color;
    canvas.drawCircle(line.start, 4, paint..style = PaintingStyle.stroke);
    canvas.drawCircle(line.start, 2, paint..style = PaintingStyle.fill);
    canvas.drawCircle(line.end, 4, paint..style = PaintingStyle.stroke);
    canvas.drawCircle(line.end, 2, paint..style = PaintingStyle.fill);
    if (start != null) {
      _drawHelpText(start, canvas, line.start.translate(-20, 0),
          color: textColor);
    }
    if (end != null) {
      _drawHelpText(end, canvas, line.end.translate(-20, 0), color: textColor);
    }
  }

  void _drawHelpText(
    String text,
    Canvas canvas,
    Offset offset, {
    Color color = Colors.lightBlue,
  }) {
    textPainter.text = TextSpan(
      text: text,
      style: TextStyle(fontSize: 12, color: color),
    );
    textPainter.layout(maxWidth: 200);
    textPainter.paint(canvas, offset);
  }
}
