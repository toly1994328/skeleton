import 'dart:math';

import 'package:dash_painter/dash_painter.dart';
import 'package:flutter/material.dart';

import 'line.dart';
import 'polar.dart';

class AnglePainter extends CustomPainter {
  final DashPainter dashPainter = const DashPainter(span: 4, step: 4);

  AnglePainter({required this.line}) : super(repaint: line);

  final Paint helpPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.lightBlue
    ..strokeWidth = 1;

  Polar2D p1 = Polar2D(pi / 4, 75);

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  final Line line;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    drawHelp(canvas, size);
    // canvas.drawCircle(p1.offset, 4, Paint());
    collect().forEach((element) {
      canvas.drawCircle(element.offset, 1, Paint());
    });
    // line.paint(canvas);
  }

  List<Polar2D> collect() {
    List<Polar2D> points = [];
    for (int i = 0; i < 360; i++) {
      double rad = i * pi / 180;
      double length = 100 * cos(4 * rad);
      points.add(Polar2D(rad, length));
    }
    return points;
  }

  void drawHelp(Canvas canvas, Size size) {
    Path helpPath = Path()
      ..moveTo(-size.width / 2, 0)
      ..relativeLineTo(size.width, 0)
      ..moveTo(0, -size.height / 2)
      ..relativeLineTo(0, size.height);

    for (int i = 0; i < 5; i++) {
      helpPath.addOval(Rect.fromCenter(
          center: Offset.zero, width: 50.0 * i, height: 50.0 * i));
      drawHelpText('${25 * i}', canvas, Offset(25.0 * i - 10, 0));
    }

    dashPainter.paint(canvas, helpPath, helpPaint);

    drawHelpText('90°', canvas, Offset(0 - 8, size.height / 2),
        color: Colors.black);
    drawHelpText('180°', canvas, Offset(-size.width / 2 - 30, 0 - 8),
        color: Colors.black);
    drawHelpText('270°', canvas, Offset(0 - 8, -size.height / 2 - 16),
        color: Colors.black);
    drawHelpText('0°', canvas, Offset(size.width / 2 + 10, 0 - 8),
        color: Colors.black);

    // canvas.drawLine(Offset.zero, p1.offset, Paint()..color=Colors.orange);

    // drawHelpText('p1', canvas, line.end.translate(-20, 0));

    // drawHelpText(
    //   '角度: ${(line.positiveRad * 180 / pi).toStringAsFixed(2)}°',
    //   canvas,
    //   Offset(
    //     -size.width / 2 + 10,
    //     -size.height / 2 + 10,
    //   ),
    // );

    // canvas.drawArc(
    //   Rect.fromCenter(center: Offset.zero, width: 20, height: 20),
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
      style: TextStyle(fontSize: 11, color: color),
    );
    textPainter.layout(maxWidth: 200);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
