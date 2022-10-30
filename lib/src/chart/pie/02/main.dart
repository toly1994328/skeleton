import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skeleton/src/chart/pie/01/model/sale_data.dart';
import 'package:skeleton/src/chart/pie/01/views/legend_item.dart';
import 'package:skeleton/src/gods/muses.dart';
import 'package:skeleton/src/gods/world/dash_painter.dart';
import 'package:skeleton/src/sector/sector.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  Offset p = Offset.zero;

  final List<SaleData> saleData = SaleData.test;
  final List<Color> colors = [
    const Color(0xff5470C6),
    const Color(0xff91CC75),
    const Color(0xffFAC858),
    const Color(0xffEE6666),
    const Color(0xff73C0DE),
    const Color(0xff3EAD79),
    const Color(0xffFD8955),
  ];
  List<SectorShape> shapes = [];

  @override
  void initState() {
    super.initState();
    List<num> data = saleData.map((e) => e.value).toList();
    List<double> perData = preprocess(data);
    shapes = mapShapeByData(perData, Size.zero);
  }

  List<double> preprocess(List<num> data) {
    num sum = 0;
    data.forEach((e) => sum += e);
    return data.map((e) => e / sum).toList();
  }

  List<SectorShape> mapShapeByData(List<double> data, Size size) {
    List<SectorShape> shapes = [];
    double cursor = 0;
    final Offset center = Offset(size.width / 2, size.height / 2);
    for (int i = 0; i < data.length; i++) {
      SectorShape shape = SectorShape(
        center: Offset(100,100),
        innerRadius: 40,
        outRadius: 80,
        startAngle: -pi / 2 + cursor * 2 * pi,
        sweepAngle: data[i] * 2 * pi,
      );
      shapes.add(shape);
      cursor += data[i];
    }
    return shapes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _cancel,
              child: SizedBox(
                height: 200,
                width: 200,
                child: CustomPaint(
                  painter:
                      Paper(shapes: shapes),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Wrap(
              direction: Axis.vertical,
              children: saleData.asMap().keys.map((int index) {
                return LegendItem(
                  data: saleData[index],
                  color: colors[index],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }



  void _onTapDown(TapDownDetails details) {
    p = details.localPosition;
    for(int i=0;i<shapes.length;i++){
      SectorShape shape = shapes[i];
      if(shape.selected){
        shape.selected = false;
        shape.outRadius-=shape.outRadius*0.06;
      }
      shape.selected = shape.contains(p);

      if(shape.selected){
        shape.outRadius+=shape.outRadius*0.06;
      }
    }

    setState(() {});
  }

  void _cancel(TapUpDetails details) {
    // p = Offset.zero;
    // setState(() {});
  }
}

class Paper extends CustomPainter {

  final List<SectorShape> shapes;
  Paper({required this.shapes});

  // double innerRadius = 40;


  @override
  void paint(Canvas canvas, Size size) {
    print('======paint=======');
    final List<Color> colors = [
      const Color(0xff5470C6),
      const Color(0xff91CC75),
      const Color(0xffFAC858),
      const Color(0xffEE6666),
      const Color(0xff73C0DE),
      const Color(0xff3EAD79),
      const Color(0xffFD8955),
    ];

    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue
      ..strokeWidth = 2;

    for (int i = 0; i < shapes.length; i++) {
      // shapes[i].center+=Offset(size.width/2, size.height/2);
      Path path = shapes[i].formPath();
      paint.color = colors[i];
      // if (i == _activeIndex) {
      //   canvas.drawShadow(path, Colors.grey, 2, false);
      // }
      canvas.drawPath(path, paint);
    }
  }


  @override
  bool shouldRepaint(covariant Paper oldDelegate) {
    bool diff = false;
    for(int i=0;i<shapes.length;i++){
     bool equal = shapes[i] == oldDelegate.shapes[i];
     if(!equal){
       diff = true;
       break;
     }
    }
    print(diff);
    return true;
  }
}
