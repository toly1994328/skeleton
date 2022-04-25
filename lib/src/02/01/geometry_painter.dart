import 'dart:math' as math;
import 'dart:ui';

import 'package:dash_painter/dash_painter.dart';
import 'package:flutter/material.dart';

import '../sdk/line.dart';
import '../sdk/muses.dart';
import '../sdk/point.dart';

class GeometryPainter extends CustomPainter {
  final DashPainter dashPainter = const DashPainter(span: 4, step: 4);

  GeometryPainter({required this.line}) : super(repaint: line);

  final Paint helpPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.lightBlue
    ..strokeWidth = 1;

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  final Line line;
  List<Offset> points = [];
  final Muses _muses = Muses();
  double angle = 40;

  @override
  void paint(Canvas canvas, Size size) {
    _muses.attach(canvas);

    canvas.translate(size.width / 2, size.height / 2);
    drawHelp(canvas, size);
    line.paint(canvas);
    Offset center = (line.start + line.end) / 2;
    Point point = Point(center.dx, center.dy);
    point.paint(canvas);

    // Line l2= Line.fromRad(start: center, rad: 45*math.pi/180, len: 100);
    Line l2 = line.branch(rad: angle * math.pi / 180, percent: 0.5, len: 100);
    l2.paint(canvas, color: Colors.red,);

    _muses.markLine(
      line,
      start: 'p0',
      end: 'p1',
      textColor: Colors.blue,
    );
    _muses.markAngle(l2,angle,text: '$angle°');
    _muses.markLine(
      l2,
      start: 'q0',
      end: 'q1',
      textColor: Colors.red,
      color: Colors.red,
    );

    // Line l3 = line.branch(rad: -45*math.pi/180, percent: 0.8, len: 100);
    // l3.paint(canvas);
    // _muses.markLine(
    //   l3,
    // );

    // Line l4 = line.branch(rad: -25*math.pi/180, percent: 0.2, len: 50);
    // l4.paintLine(canvas);
    // l4.paintHelp(canvas);

    // Point point3 = Point(l3.end.dx,l3.end.dy);
    // point3.paint(canvas);
  }

  void drawHelp(Canvas canvas, Size size) {
    Path helpPath = Path()
      ..moveTo(-size.width / 2, 0)
      ..relativeLineTo(size.width, 0)
      ..moveTo(0, -size.height / 2)
      ..relativeLineTo(0, size.height);
    dashPainter.paint(canvas, helpPath, helpPaint);

    drawHelpText(
      '角度: ${(angle).toInt()}°',
      canvas,
      Offset(
        -size.width / 2 + 10,
        -size.height / 2 + 10,
      ),
    );

    // canvas.drawArc(
    //   Rect.fromCenter(center: line.start, width: 20, height: 20),
    //   0,
    //   line.positiveRad,
    //   false,
    //   helpPaint,
    // );

    // canvas.save();
    // Offset center = const Offset(60, 60);
    // canvas.translate(center.dx, center.dy);
    // canvas.rotate(line.positiveRad);
    // canvas.translate(-center.dx, -center.dy);
    // canvas.drawCircle(center, 4, helpPaint);
    // canvas.drawRect(
    //     Rect.fromCenter(center: center, width: 30, height: 60), helpPaint);
    // canvas.restore();
  }

  void drawHelpText(
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
