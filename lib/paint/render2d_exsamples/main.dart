import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:render2d/render2d.dart';
import 'dart:ui' as ui;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final ShapePainter _painter = ShapePainter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: createCanvas,
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(400, 400),
          painter: _painter,
        ),
      ),
    );
  }

  void createCanvas() async {
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    Size boxSize = const Size(10240, 10240);
    _painter.paint(canvas, boxSize);
    Picture picture = recorder.endRecording();
    int imgWidth = boxSize.width.toInt();
    int imgHeight = boxSize.height.toInt();
    ui.Image image = await picture.toImage(imgWidth, imgHeight);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    if (byteData != null) {
      File file = File("D:\\Temp\\canvas\\box_${imgWidth}_${imgHeight}.png");
      if (!file.existsSync()) {
        await file.create(recursive: true);
      }
      file.writeAsBytes(byteData.buffer.asUint8List());
    }
  }
}

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 1;
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.black12);
    canvas.drawCircle(Offset(100, 100), 5, Paint()..color = Colors.red);

    Circle circle = Circle(CircleShape(cx: 100, cy: 100, r: 50));

    canvas.drawCircle(Offset(240, 100), 5, Paint()..color = Colors.red);

    Arc arc = Arc(ArcShape(
        cx: 240,
        cy: 100,
        r: 50,
        startAngle: 0 * pi / 180,
        endAngle: 120 * pi / 180,
        clockwise: false));

    canvas.drawCircle(
        Offset(100, 100), 50, Paint()..color = Colors.red.withOpacity(0.1));

    Path path = circle.builder();
    canvas.drawPath(path, paint);
    canvas.drawPath(arc.builder(), paint);

    Ring ring = Ring(RingShape(cx: 100, cy: 240, r: 50, r0: 30));
    canvas.drawPath(ring.builder(), Paint());

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
