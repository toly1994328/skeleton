import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../decorate/snow/snow_painter.dart';

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
          size: const Size(100,100),
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
    int imgHeight =  boxSize.height.toInt();
    ui.Image image = await picture.toImage(imgWidth,imgHeight);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    if (byteData != null) {
      File file = File("D:\\Temp\\canvas\\box_${imgWidth}_${imgHeight}.png");
      if(!file.existsSync()){
        await file.create(recursive: true);
      }
      file.writeAsBytes(byteData.buffer.asUint8List());
    }
  }
}

class ShapePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    canvas.drawRRect(RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(size.width*0.1)),paint );
    paint..style=PaintingStyle.stroke..color=Colors.white..strokeWidth=size.width*0.02;
    canvas.drawCircle(Offset(size.width/2 , size.height/2),size.width/2.1, paint);
    SnowPainter(color: Colors.white).paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
