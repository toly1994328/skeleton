import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skeleton/src/chart/pie/model/sale_data.dart';
import 'package:skeleton/src/chart/pie/views/legend_item.dart';
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
                      Paper(p: p, data: saleData.map((e) => e.value).toList()),
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
    setState(() {});
  }

  void _cancel(TapUpDetails details) {
    // p = Offset.zero;
    // setState(() {});
  }
}

class Paper extends CustomPainter {
  final Offset p;
  final List<num> data;

  Paper({required this.p, required this.data});

  Muses muses = Muses();
  DashPainter dashPainter = const DashPainter();
  double innerRadius = 40;

  int _activeIndex = -1;

  @override
  void paint(Canvas canvas, Size size) {
    final List<Color> colors = [
      const Color(0xff5470C6),
      const Color(0xff91CC75),
      const Color(0xffFAC858),
      const Color(0xffEE6666),
      const Color(0xff73C0DE),
      const Color(0xff3EAD79),
      const Color(0xffFD8955),
    ];
    muses.attach(canvas);
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue
      ..strokeWidth = 2;

    List<SectorShape> shapes = mapShapeByData(preprocess(data), size);
    for (int i = 0; i < shapes.length; i++) {
      Path path = shapes[i].formPath();
      paint.color = colors[i];
      if (i == _activeIndex) {
        canvas.drawShadow(path, Colors.grey, 2, false);
      }
      canvas.drawPath(path, paint);
    }
  }

  List<SectorShape> mapShapeByData(List<double> data, Size size) {
    _activeIndex = -1;
    List<SectorShape> shapes = [];
    double cursor = 0;
    final Offset center = Offset(size.width / 2, size.height / 2);
    for (int i = 0; i < data.length; i++) {
      SectorShape shape = SectorShape(
        center: center,
        innerRadius: 40,
        outRadius: 80,
        startAngle: -pi / 2 + cursor * 2 * pi,
        sweepAngle: data[i] * 2 * pi,
      );

      double rad = shape.startAngle + data[i] * 2 * pi / 2;
      if (shape.contains(p)) {
        shape.outRadius += 5;
        _activeIndex = i;
        // shape.center = shape.center.translate(5 * cos(rad), 5 * sin(rad));
      }
      shapes.add(shape);
      cursor += data[i];
    }
    return shapes;
  }

  List<double> preprocess(List<num> data) {
    num sum = 0;
    data.forEach((e) => sum += e);
    return data.map((e) => e / sum).toList();
  }

  @override
  bool shouldRepaint(covariant Paper oldDelegate) {
    return oldDelegate.p != p;
  }
}
