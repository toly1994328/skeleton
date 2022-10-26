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

  // This widget is the root of your application.
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

class _MyHomePageState extends State<MyHomePage> {

  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    loadImageFromAssets('assets/images/wy_300x200.webp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _tap,
        child: Center(
          child: SizedBox(
            height: 200,
            width: 200,
            child: CustomPaint(
              painter: Paper(
                image: _image
              ),
            ),
          ),
        ),
      ),
    );
  }

  //读取 assets 中的图片
  void loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    _image = await decodeImageFromList(data.buffer.asUint8List());
    setState(() {

    });
  }
  SectorShape shape = SectorShape(
    center: Offset.zero,
    innerRadius: 40,
    outRadius: 80,
    startAngle: 150 * pi / 180,
    sweepAngle: -80 * pi / 180,
  );
  void _tap() {
    print('=====_tap=======');
    int time = DateTime.now().millisecondsSinceEpoch;
    for(int i = 0;i<10000;i++){
      // shape.formPath();
      // // Path path = Path();
      // double startRad = 0;
      // double endRad = 0 + 0;
      // double r0 = 0;
      // double r1 = 0;
      // Offset p0 = Offset(cos(startRad) * r0, sin(startRad) * r0);
      // Offset p1 = Offset(cos(startRad) * r1, sin(startRad) * r1);
      // Offset q0 = Offset(cos(endRad) * r0, sin(endRad) * r0);
      // Offset q1 = Offset(cos(endRad) * r1, sin(endRad) * r1);
      // Path()
      //   ..moveTo(p0.dx, p0.dy)
      //   ..lineTo(p1.dx, p1.dy)
      //   ..arcToPoint(q1, radius: Radius.circular(r1), clockwise: true)
      //   ..lineTo(q0.dx, q0.dy)
      //   ..arcToPoint(p0, radius: Radius.circular(r0),clockwise: false);
    }
    int endTime = DateTime.now().millisecondsSinceEpoch;
    print('${endTime-time}ms');

  }
}

class Paper extends CustomPainter {

  final ui.Image? image;


  Paper({this.image});

  Muses muses = Muses();
  DashPainter dashPainter = const DashPainter();

  @override
  void paint(Canvas canvas, Size size) {
    muses.attach(canvas);
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue
      ..strokeWidth = 2;

    if(image!=null){
      // paint.shader=ImageShader(
      //     image!,
      //     TileMode.repeated,
      //     TileMode.repeated,
      //     Matrix4.diagonal3Values(0.5, 0.5, 1).storage
      //     );
    }

    SectorShape shape = SectorShape(
      center: Offset.zero,
      innerRadius: 40,
      outRadius: 80,
      startAngle: 150 * pi / 180,
      sweepAngle: -80 * pi / 180,
    );


    canvas.drawPath(shape.formPath(), paint);
    Paint paint2 = Paint()..style=PaintingStyle.stroke;
    canvas.drawPath(shape.formPath(), paint2);

    final double startAngle = 150 * pi / 180;
    final double sweepAngle = -80 * pi / 180;
    // muses.markSector(SectorShape(center: Offset(0, 0), innerRadius: 40, outRadius: 80, startAngle: startAngle, sweepAngle: sweepAngle));
    muses.markCircle(const Offset(0, 0), 80);
    muses.markCircle(const Offset(0, 0), 40);
    muses.markLine(Line.fromRad(start: Offset(0, 0), rad: startAngle, len: 80));
    muses.markLine(Line.fromRad(
        start: Offset(0, 0), rad: startAngle + sweepAngle, len: 80));
  }

  @override
  bool shouldRepaint(covariant Paper oldDelegate) {
    return false;
  }
}
