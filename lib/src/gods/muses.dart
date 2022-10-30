// 缪斯 - 希腊神话中主司艺术与科学的九位古老文艺女神的总称
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skeleton/src/sector/sector.dart';

import 'world/dash_painter.dart';
import 'world/line.dart';

enum PaintType {
  fill,
  stork,
  daskStork,
}

class PaintAttr {
  final Color? color;
  final double? strokeWidth;

  PaintAttr({this.color, this.strokeWidth});

  void mergePaint(Paint paint) {
    paint.color = color ?? paint.color;
    paint.strokeWidth = strokeWidth ?? paint.strokeWidth;
  }
}

class Muses {
  Paint paint = Paint();
  DashPainter dashPainter = const DashPainter();

  late Canvas canvas;
  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  void attach(Canvas canvas) {
    this.canvas = canvas;
  }

  void markCircle(Offset center, double radius,
      {PaintType type = PaintType.daskStork, PaintAttr? attr}) {
    Paint paint = Paint();
    Path path = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
    Paint _old = paint;
    if (attr != null) {
      attr.mergePaint(paint);
    }
    switch (type) {
      case PaintType.fill:
        paint.style = PaintingStyle.fill;
        canvas.drawPath(path, paint);
        break;
      case PaintType.stork:
        paint.style = PaintingStyle.stroke;
        canvas.drawPath(path, paint);
        break;
      case PaintType.daskStork:
        paint.style = PaintingStyle.stroke;
        dashPainter.paint(canvas, path, paint);
        break;
    }
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
    if (angle == 90) {
      canvas.save();
      canvas.translate(line.start.dx, line.start.dy);
      canvas.rotate(line.rad - pi / 2);
      canvas.translate(-line.start.dx, -line.start.dy);
      canvas.drawRect(
          Rect.fromPoints(line.start, line.start + Offset(8, 8)), paint);
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

  void markNode(
    Line line,
    String content, {
    Color color = Colors.black,
    bool end = false,
  }) {
    paint.color = color;

    if (!end) {
      canvas.drawCircle(line.start, 10, paint..style = PaintingStyle.fill);
      _drawHelpText(content, canvas, line.start,
          color: Colors.white, center: true);
    } else {
      canvas.drawCircle(line.end, 10, paint..style = PaintingStyle.fill);
      _drawHelpText(content, canvas, line.end,
          color: Colors.white, center: true);
    }
  }

  void markSector(SectorShape shape) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 2;

    double startRad = shape.startAngle;
    double endRad = shape.startAngle + shape.sweepAngle;
    double r0 = shape.innerRadius;
    double r1 = shape.outRadius;

    Offset p0 = Offset(cos(startRad) * r0, sin(startRad) * r0);
    Offset p1 = Offset(cos(startRad) * r1, sin(startRad) * r1);

    Offset q0 = Offset(cos(endRad) * r0, sin(endRad) * r0);
    Offset q1 = Offset(cos(endRad) * r1, sin(endRad) * r1);
    Path path = Path()
          ..moveTo(p0.dx, p0.dy)
          ..lineTo(p1.dx, p1.dy)
          ..arcToPoint(q1,
              radius: Radius.circular(r1), clockwise: false)
          ..lineTo(q0.dx, q0.dy)
          ..arcToPoint(p0, radius: Radius.circular(r0))

        //Rect.fromCircle(center: shape.center, radius: shape.innerRadius), shape.startAngle, shape.sweepAngle, false
        //   ..addArc(Rect.fromCircle(center: shape.center, radius: shape.outRadius),
        //       shape.startAngle, shape.sweepAngle,)
        //   ..addArc(Rect.fromCircle(center: shape.center, radius: shape.innerRadius),
        //     shape.startAngle, shape.sweepAngle,)
        //   ..moveTo(start1.dx, start1.dy)
        //   ..lineTo(end1.dx, end1.dy)
        ;
    canvas.drawPath(path, paint);
  }

  void markLine(
    Line line, {
    Color color = Colors.black,
    bool close = true,
    String? start,
    String? end,
    Color textColor = Colors.lightBlue,
  }) {
    paint.color = color;
    if (close) {
      canvas.drawLine(line.start, line.end, paint);
    }
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

  void markCurveLine(
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

    Path path = Path();
    path.moveTo(line.start.dx, line.start.dy);
    path.quadraticBezierTo(
        line.start.dx, line.end.dy, line.end.dx, line.end.dy);
    canvas.drawPath(path, paint..style = PaintingStyle.stroke);
  }

  void _drawHelpText(String text, Canvas canvas, Offset offset,
      {Color color = Colors.lightBlue, bool center = false}) {
    textPainter.text = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: 12,
        color: color,
      ),
    );
    textPainter.layout(maxWidth: 200);
    if (center) {
      Size size = textPainter.size;
      textPainter.paint(
          canvas, offset.translate(-size.width / 2, -size.height / 2));
      return;
    }
    textPainter.paint(canvas, offset);
  }
}
