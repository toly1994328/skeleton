import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skeleton/src/linker.dart';
import 'package:skeleton/src/paper.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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

  ShapePainter _painter = ShapePainter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: createCanvas,
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(100,100),
          painter: _painter,
        ),
      ),
    );
  }

  void createCanvas() async {
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    Size boxSize = const Size(100, 100);
    _painter.paint(canvas, boxSize);
    Picture picture = recorder.endRecording();
    ui.Image image =
        await picture.toImage(boxSize.width.toInt(), boxSize.height.toInt());
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    if (byteData != null) {
      File file = File(r"E:\Temp\desk\box.png");
      file.writeAsBytes(byteData.buffer.asUint8List());
    }
  }
}

class ShapePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    canvas.drawRect(Offset.zero & size,paint );
    paint..style=PaintingStyle.stroke..color=Colors.redAccent..strokeWidth=2;
    canvas.drawCircle(Offset(size.width/2 , size.height/2),40, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
