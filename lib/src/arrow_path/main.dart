import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          child: CustomPaint(
            painter: ArrowPainter(),
          ),
        ),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  final Paint arrowPainter = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(
    //     Offset.zero & size, Paint()..color = Colors.grey.withOpacity(0.3));
    Offset p0 = Offset(0, 0);
    Offset p1 = Offset(200, 0);
    arrowPainter
      ..style = PaintingStyle.fill
      ..color = Colors.red;
    Path result1 = getArrowPathByOffset(p0,p1,arrowWidth: 4,angle: 60,hasStart: true,hasEnd: true);
    canvas.drawPath(result1, arrowPainter);
    canvas.translate(0, 30);
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
