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

  Offset p = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
            onTap: _tap,
            onTapDown: _onTapDown,
            onTapUp: _cancel,
            child:SizedBox(
            height: 200,
            width: 200,
            child: ColoredBox(
              color: Colors.black12,
              child: CustomPaint(
                painter: Paper(
                  image: _image,
                  p: p
                ),
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

  void _tap() {
    SectorShape shape = SectorShape(
      center: Offset.zero,
      innerRadius: 40,
      outRadius: 80,
      startAngle: 30 * pi / 180,
      sweepAngle: 80 * pi / 180,
    );
    // Offset offset = const Offset(12.7, 48.4);
    // Offset offset = const Offset(0, 0);
    // Path path = shape.formPath();
    //  int time = DateTime.now().millisecondsSinceEpoch;
    //  for(int i = 0;i<1000000;i++){
    //
    //     //path.contains(offset); //481ms
    //     // shape.contains(offset); //107ms
    //
    //    // path.contains(offset); // 229ms
    //    // shape.contains(offset); // 34ms
    //
    //     // print("=path.contains===${path.contains(offset)}=======");
    //     // print("=shape.contains===${shape.contains(offset)}=======");
    //  }
    // int endTime = DateTime.now().millisecondsSinceEpoch;
    //  print('${endTime-time}ms');

  }

  void _onTapDown(TapDownDetails details) {
    p = details.localPosition;
    print('===_onTapDown====${details.localPosition}====');
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

  final ui.Image? image;
  final Offset p;


  Paper({this.image,required this.p});

  Muses muses = Muses();
  DashPainter dashPainter = const DashPainter();

  @override
  void paint(Canvas canvas, Size size) {
    muses.attach(canvas);
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
      center: Offset(size.width / 2, size.height / 2),
      innerRadius: 40,
      outRadius: 80,
      startAngle: 30 * pi / 180,
      sweepAngle: 280 * pi / 180,
    );
   bool contain = shape.contains(p);
   if(contain){
     canvas.drawPath(shape.formPath(), paint);
     Paint paint2 = Paint()..style=PaintingStyle.stroke;
     canvas.drawPath(shape.formPath(), paint2);
   }
    // canvas.drawPath(shape.formPath(), paint);
    // Paint paint2 = Paint()..style=PaintingStyle.stroke;
    // canvas.drawPath(shape.formPath(), paint2);
    // canvas.drawPath(shape.formPath(), paint);
    // Paint paint2 = Paint()..style=PaintingStyle.stroke;
    // canvas.drawPath(shape.formPath(), paint2);
    canvas.translate(size.width / 2, size.height / 2);
    final double startAngle = shape.startAngle;
    final double sweepAngle = shape.sweepAngle;
    // muses.markSector(SectorShape(center: Offset(0, 0), innerRadius: 40, outRadius: 80, startAngle: startAngle, sweepAngle: sweepAngle));
    muses.markCircle(const Offset(0, 0), 80);
    muses.markCircle(const Offset(0, 0), 40);
    muses.markLine(Line.fromRad(start: Offset(0, 0), rad: startAngle, len: 80));
    muses.markLine(Line.fromRad(
        start: Offset(0, 0), rad: startAngle + sweepAngle, len: 80));
  }

  @override
  bool shouldRepaint(covariant Paper oldDelegate) {
    return oldDelegate.p!=p;
  }
}
