import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skeleton/src/gods/muses.dart';
import 'package:skeleton/src/gods/world/dash_painter.dart';
import 'package:skeleton/src/gods/world/line.dart';
import 'package:skeleton/src/sector/sector.dart';
import 'dart:ui' as ui;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  Offset p = Offset.zero;
   late final AnimationController _ctrl = AnimationController(vsync: this,duration: Duration(milliseconds:500));

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _cancel,
            child:SizedBox(
            height: 200,
            width: 200,
            child: CustomPaint(
              painter: Paper(
                p: p,
                progress: _ctrl
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    p = details.localPosition;
    _ctrl.forward(from: 0);
    setState(() {

    });
  }

  void _cancel(TapUpDetails details ) {
    p = Offset.zero;
    setState(() {

    });
  }
}

class Paper extends CustomPainter {

  final Offset p;
  final Animation<double> progress;


  Paper({required this.p,required this.progress}):super(repaint: progress);

  Muses muses = Muses();
  DashPainter dashPainter = const DashPainter();

  @override
  void paint(Canvas canvas, Size size) {
    muses.attach(canvas);
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue
      ..strokeWidth = 2;
    SectorShape shape = SectorShape(
      center: Offset(size.width / 2, size.height / 2),
      innerRadius: 40,
      outRadius: 80,
      startAngle: 30 * pi / 180,
      sweepAngle: 90 * pi / 180*progress.value,
    );

     canvas.drawPath(shape.formPath(), paint);
     Paint paint2 = Paint()..style=PaintingStyle.stroke;
     canvas.drawPath(shape.formPath(), paint2);


    // 绘制辅助线
    canvas.translate(size.width / 2, size.height / 2);
    final double startAngle = shape.startAngle;
    final double sweepAngle = shape.sweepAngle;
    muses.markCircle(Offset.zero, 80);
    muses.markCircle(Offset.zero, 40);
    muses.markLine(Line.fromRad(start: Offset.zero, rad: startAngle, len: 80));
    muses.markLine(Line.fromRad(start:  Offset.zero, rad: startAngle + sweepAngle, len: 80));
  }

  @override
  bool shouldRepaint(covariant Paper oldDelegate) {
    return oldDelegate.p!=p;
  }
}
