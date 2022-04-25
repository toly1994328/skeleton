import 'dart:math' as math;
import 'dart:ui';

import 'package:dash_painter/dash_painter.dart';
import 'package:flutter/material.dart';

import '../sdk/line.dart';
import '../sdk/muses.dart';

class Node {
  final String text;
  final bool red;
  final Line line;
  final bool paintEnd;

  Node(this.text, this.red, this.line, {this.paintEnd = true});
}

class Config {
  final double len;
  final double angle;
  final double percent;

  Config({
    required this.len,
    required this.angle,
    required this.percent,
  });

  Config copyWith({
    double? len,
    double? angle,
    double? percent,
  }) {
    return Config(
      len: len ?? this.len,
      angle: angle ?? this.angle,
      percent: percent ?? this.percent,
    );
  }

  @override
  String toString() {
    return 'Config{len: $len, angle: $angle, percent: $percent}';
  }
}

class GeometryPainter extends CustomPainter {
  final Animation<double> progress;

  GeometryPainter({required this.progress}) : super(repaint: progress);

  final DashPainter dashPainter = const DashPainter(span: 4, step: 4);

  final Paint helpPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.lightBlue
    ..strokeWidth = 1;

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  Line line = Line(start: const Offset(-100, 0), end: const Offset(-60, 0));
  List<Offset> points = [];
  final Muses _muses = Muses();

  Node appendChild(
    // Line line,
    // String label,
    // bool red,
    Node node,
    double angle, {
    bool zero = false,
    bool atStart = false,
  }) {
    Line newLine = node.line.branch(
      rad: angle * math.pi / 180,
      percent: atStart ? 0 : 1,
      len: zero ? 0 : 50,
    );
    return Node(
      node.text,
      node.red,
      newLine,
      paintEnd: node.paintEnd,
    );
  }

  List<Node> nodes = [];

  void drawNode() {
    for (var node in nodes) {
      Color color = node.red ? Colors.red : Colors.black;
      node.line.paint(_muses.canvas);
      _muses.markNode(node.line, node.text, color: color, end: node.paintEnd);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _muses.attach(canvas);
    canvas.translate(size.width / 2, size.height / 2);
    drawHelp(canvas, size);

    line.paint(canvas);
    _muses.markNode(line, '8');

    double len= progress.value*60;
    for(int i=0;i<1;i++){
      double angle = 45-10.0*i;
      Line l1 =line.branch(rad: angle/180*math.pi, percent: 1, len: -len/math.cos(angle/180*math.pi));
      _muses.markCurveLine(l1);
      Line l2 =line.branch(rad: -angle/180*math.pi, percent: 1, len: -len/math.cos(-angle/180*math.pi));
      _muses.markCurveLine(l2);
    }

    // Line l2 =line.branch(rad: 45/180*math.pi, percent: 1, len: -60/math.cos(45/180*math.pi));
    // _muses.markCurveLine(l2);
    // Line l3 =line.branch(rad: -45/180*math.pi, percent: 1, len: -60/math.cos(-45/180*math.pi));
    // _muses.markCurveLine(l3);
    //
    //
    // Line l4 =line.branch(rad: 35/180*math.pi, percent: 1, len: -60/math.cos(35/180*math.pi));
    // _muses.markCurveLine(l4);
    //
    // Line l5 =line.branch(rad: -35/180*math.pi, percent: 1, len: -60/math.cos(-35/180*math.pi));
    // _muses.markCurveLine(l5);
    // Line l6 =line.branch(rad: -25/180*math.pi, percent: 1, len: -60/math.cos(-25/180*math.pi));
    // _muses.markCurveLine(l6);
    //
    // Line l7 =line.branch(rad: 25/180*math.pi, percent: 1, len: -60/math.cos(25/180*math.pi));
    // _muses.markCurveLine(l7);

    // Node l1 = appendChild(Node('9', true, line,paintEnd: false), -135);
    // Node l2 = appendChild(Node('14', false, l1.line, ), 135 + 45, atStart: true);
    // Node l3 = appendChild(Node('24', true, l2.line,), 135 + 45);
    // Node l4 = appendChild(Node('6', false, l1.line, ), 90, atStart: true);
    // Node l5 = appendChild(Node('4', true, l4.line, ), -135+45);
    // Node l6 = appendChild(Node('3', true, l4.line,), 135+45);

    // nodes.addAll([
    //   l6,
    //   l5,
    //   l3,
    //   l2,
    //   l4,
    //   l1,
    // ]);
    // drawNode();

    // Line l7 = line.branch(
    //   rad: (-135) * math.pi / 180,
    //   percent: 1,
    //   len: config.value.len,
    // );
    //
    // Line l8 = l7.branch(
    //   rad: (135+45) * math.pi / 180,
    //   percent: 1,
    //   len: config.value.len,
    // );
    //
    // l8.paint(
    //   canvas,
    // );
    // _muses.markNode(
    //     l8,
    //     '24',
    //     end: true,
    //     color: Colors.red
    // );
    //
    // l7.paint(
    //   canvas,
    // );
    // _muses.markNode(
    //     l7,
    //     '14',
    //     end: true,
    //     // color: Colors.red
    // );
    //
    // // Line l2= Line.fromRad(start: center, rad: 45*math.pi/180, len: 100);
    // Line l2 = line.branch(
    //     rad: 135 * math.pi / 180,
    //     percent: 1,
    //     len: config.value.len,
    // );
    //
    //
    //
    //
    // l2.paint(
    //   canvas,
    // );
    //
    // _muses.markNode(
    //   line,
    //   '10'
    // );
    // _muses.markNode(
    //   l2,
    //     '9',
    //   color: Colors.red
    // );
    //
    // Line l3 = l2.branch(
    //   rad: (135+60) * math.pi / 180,
    //   percent: 1,
    //   len: config.value.len,
    // );
    //
    // Line l5 = l2.branch(
    //   rad: (135+60+60) * math.pi / 180,
    //   percent: 1,
    //   len: config.value.len,
    // );
    //
    // l5.paint(
    //   canvas,
    // );
    // _muses.markNode(
    //     l5,
    //     '4',
    //     end: true,
    //     color: Colors.red
    // );
    //
    //
    //
    // l3.paint(
    //   canvas,
    // );
    // _muses.markNode(
    //     l3,
    //     '6'
    //     // color: Colors.red
    // );
    //
    //
    //
    // Line l4 = l3.branch(
    //   rad: 0,
    //   percent: 1,
    //   len: 0,
    // );
    //
    // l4.paint(
    //   canvas,
    // );
    // _muses.markNode(
    //   l4,
    //     '3',
    //   color: Colors.red
    // );

    //
    //
    // _muses.markAngle(l2, config.value.angle, text: '${config.value.angle}°');
    // _muses.markLine(
    //   l2,
    // );
    // Line l3 = line.branch(
    //   rad: -config.value.angle * math.pi / 180,
    //   percent: config.value.percent,
    //   len: config.value.len,
    // );
    // // Line l3 = line.branch(rad: -45*math.pi/180, percent: 0.8, len: 100);
    // l3.paint(canvas);
    // _muses.markLine(
    //   l3,
    // );
    //
    // Line l4 = line.branch(
    //   rad: -135 * math.pi / 180,
    //   percent: 1,
    //   len: 80,
    // );
    // l4.paint(canvas);
    //
    // _muses.markLine(
    //   l4,
    // );
    // Line l5 = line.branch(
    //   rad: 135 * math.pi / 180,
    //   percent: 1,
    //   len: 80,
    // );
    // l5.paint(canvas);
    //
    // _muses.markLine(
    //   l5,
    // );
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

    // drawHelpText(
    //   '角度: ${(config.value.angle).toInt()}°',
    //   canvas,
    //   Offset(
    //     -size.width / 2 + 10,
    //     -size.height / 2 + 10,
    //   ),
    // );

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
