import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeleton/src/arrow_path/arrow/port_path.dart';

import 'arrow/arrow_path.dart';
import 'arrow/old.dart';
import 'coordinate_pro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('箭头路径绘制'),
      ),
      body: CustomPaint(
        painter: ArrowPainter(),
        child: Container(),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  final Paint arrowPainter = Paint();

  Coordinate coordinate = Coordinate();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    // canvas.drawRect(
    //     Offset.zero & size, Paint()..color = Colors.grey.withOpacity(0.3));
    canvas.translate(size.width / 2, size.height / 2);
    Offset p0 = Offset(40, 40);
    Offset p1 = Offset(200, 140);

    double width = 10;
    double height = 10;
    Size portSize = Size(width, height);

    ArrowPath arrow = ArrowPath(
      head:
          PortPath(p0, portSize, portPath: const ThreeAnglePortPath(rate: 0.5)),
      tail:
          PortPath(p1, portSize, portPath: const ThreeAnglePortPath(rate: 0.8)),
    );

    arrowPainter
      ..style = PaintingStyle.fill
      // ..style = PaintingStyle.stroke
      ..color = Colors.green;
    // Path result1 = getArrowPathByOffset(p0,p1,arrowWidth: 4,angle: 60,hasStart: true,hasEnd: true);

    canvas.drawPath(arrow.formPath(), arrowPainter);

    ArrowPath arrow2 = ArrowPath(
      head: PortPath(
        p0.translate(40, 0),
        const Size(10, 10),
        portPath: const ThreeAnglePortPath(rate: 0.8),
      ),
      tail: PortPath(
        p1.translate(40, 0),
        const Size(8, 8),
        portPath: const CirclePortPath(),
      ),
    );
    arrowPainter
      ..style = PaintingStyle.fill
      ..strokeWidth
      // ..style = PaintingStyle.stroke
      ..color = Colors.red;
    // Path result1 = getArrowPathByOffset(p0,p1,arrowWidth: 4,angle: 60,hasStart: true,hasEnd: true);

    canvas.drawPath(arrow2.formPath(), arrowPainter);

    ArrowPath arrow3 = ArrowPath(
      head: PortPath(Offset(-40, 40), portSize),
      tail: PortPath(Offset(-200, 120), portSize),
    );
    arrowPainter
      ..style = PaintingStyle.fill
      ..strokeWidth
      // ..style = PaintingStyle.stroke
      ..color = Colors.blue;
    // Path result1 = getArrowPathByOffset(p0,p1,arrowWidth: 4,angle: 60,hasStart: true,hasEnd: true);

    canvas.drawPath(arrow3.formPath(), arrowPainter);

    // canvas.translate(0, 30);
    // Path result2 = getArrowPathByOffset(p0,p1,arrowWidth: 4,angle: 60,hasStart: true,hasEnd: true);
    // canvas.drawPath(result2, arrowPainter);
    // canvas.translate(0, 30);
    // Path result3 = getArrowPathByOffset(p0,p1,arrowWidth: 4,angle: 60,hasStart: false,hasEnd: true);
    // canvas.drawPath(result3, arrowPainter);
    //
    // canvas.translate(0, 30);
    // Path result4 = getArrowPathByOffset(p0,p1,arrowWidth: 4,angle: 45,hasStart: false,hasEnd: true,arrowRate: 1.8);
    // canvas.drawPath(result4, arrowPainter);
    //
    // canvas.translate(0, 45);
    // Path result6 = getArrowPathByOffset(p0,p1,arrowWidth: 10,angle: 45,hasStart: true,hasEnd: true,arrowRate: 1.2,widthRate: 0.7);
    // canvas.drawPath(result6, arrowPainter);
    //
    // canvas.translate(0, 45);
    // Path result7 = getArrowPathByOffset(p0,p1,arrowWidth: 2,angle: 60,hasStart: true,hasEnd: true,arrowRate: 0.9);
    // canvas.drawPath(result7, arrowPainter);
    //
    // canvas.translate(0, 45);
    // Path result5 = getArrowPathByOffset(p0,p1,arrowWidth: 4,angle: 90,hasStart: true,hasEnd: true,arrowRate: 0,heightRate: 0.6,widthRate: 1.8);
    // canvas.drawPath(result5, arrowPainter);
  }

  Path arrowByOffset(Offset p0, Offset p1,
      {double strokeWidth = 16, double arrowHeight = 20, double angle = 60}) {
    double a = (p1 - p0).direction;
    a = a < 0 ? 2 * pi + a : a;
    double halfStrokeWidth = strokeWidth / 2;

    p0 = p0 + Offset(arrowHeight * cos(a), arrowHeight * sin(a));

    print('a:${a * 180 / pi}°');
    //
    //   double get positiveRad => rad < 0 ? 2 * pi + rad : rad;
    double len = (p1 - p0).distance;

    double halfWidth = arrowHeight * sin(angle / 180 * pi / 2);
    double rate = 0.4;
    Offset start = Offset(p0.dx - arrowHeight * rate * cos(a),
        p0.dy - arrowHeight * rate * sin(a));
    // Offset start = p0;
    Path head = Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(halfWidth * sin(a) + p0.dx, -halfWidth * cos(a) + p0.dy)
      ..lineTo(-arrowHeight * cos(a) + p0.dx, -arrowHeight * sin(a) + p0.dy)
      ..lineTo(-halfWidth * sin(a) + p0.dx, halfWidth * cos(a) + p0.dy)
      ..close();

    Offset end =
        Offset(p1.dx - arrowHeight * cos(a), p1.dy - arrowHeight * sin(a));
    Offset endTarget =
        end + Offset(arrowHeight * rate * cos(a), arrowHeight * rate * sin(a));
    Path tail = Path()
      ..moveTo(endTarget.dx, endTarget.dy)
      ..lineTo(-halfWidth * sin(a) + end.dx, halfWidth * cos(a) + end.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(halfWidth * sin(a) + end.dx, -halfWidth * cos(a) + end.dy)
      ..close();

    len = len - arrowHeight * rate * rate;
    Path path = Path()
          ..moveTo(start.dx, start.dy)
          ..relativeLineTo(halfStrokeWidth * sin(a), -halfStrokeWidth * cos(a))
          ..relativeLineTo(len * cos(a), len * sin(a))
          ..relativeLineTo(-strokeWidth * sin(a), strokeWidth * cos(a))
          ..relativeLineTo(-len * cos(a), -len * sin(a))
          ..close()
        // ..lineTo(p1.dx, p1.dy)
        ;

    // return tail;
    var path2 = Path.combine(PathOperation.union, path, head);
    return Path.combine(PathOperation.union, path2, tail);
  }

  Path getArrowPathByOffset(
    Offset p0,
    Offset p1, {
    double arrowWidth = 2,
    double arrowRate = 0.9,
    double heightRate = 1,
    double widthRate = 1,
    double angle = 60,
    bool hasStart = false,
    bool hasEnd = true,
  }) {
    double arrowRad = angle * pi / 180;
    double arrowHeight = arrowWidth * 5*heightRate;
    double a = arrowHeight / 2;
    double b = a / tan(arrowRad / 2)*widthRate;

    double len = a * tan(arrowRad / 2 * arrowRate);

    Path endArrowPath = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p1.dx - b, p1.dy - a)
      ..lineTo(p1.dx - b + len, 0)
      ..lineTo(p1.dx - b, p1.dy + a)
      ..close();

    double startOffsetX = hasStart ? b - len : 0;
    double endOffsetX = 0;
    if (hasStart && hasEnd) {
      startOffsetX = b - len;
      endOffsetX = 2 * (b - len);
    }

    if (!hasStart && hasEnd) {
      endOffsetX = b - len;
    }

    if (hasStart && !hasEnd) {
      startOffsetX = b - len;
      endOffsetX = b - len;
    }

    Path path = Path();
    path
      ..moveTo(p0.dx + startOffsetX, p0.dy)
      ..relativeLineTo(0, arrowWidth)
      ..relativeLineTo(p1.dx - endOffsetX, 0)
      ..relativeLineTo(0, -arrowWidth)
      ..close();
    path = path.shift(Offset(0, -arrowWidth / 2));

    Path startArrowPath = Path();
    startArrowPath = Path()
      ..moveTo(p0.dx, p0.dy)
      ..lineTo(p0.dx + b, p0.dy - a)
      ..lineTo(p0.dx + b - len, 0)
      ..lineTo(p0.dx + b, p0.dy + a)
      ..close();

    Path result = path;

    if (hasStart) {
      result = Path.combine(PathOperation.union, result, startArrowPath);
    }

    if (hasEnd) {
      result = Path.combine(PathOperation.union, result, endArrowPath);
    }
    return result;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
