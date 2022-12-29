import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  late AnimationController _ctrl;
  final AnimValues values = AnimValues();

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(_collectPoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("AppBar"),),
      body: GestureDetector(
        onTap: _startAnim,
        child: Center(
          child: CustomPaint(
            size: Size(300,300),
            painter:AnimValuePainter(
                values
            ) ,
          ),
        ),
      ),
    );
  }

  void _collectPoint() {
    values.add(_ctrl.value);
    setState(() {

    });
  }

  void _startAnim() {
    values.clear();
    _ctrl.forward(from: 0);
  }
}

class AnimValues extends ChangeNotifier{
  final List<double> data = [];

  void add(double value) {
    data.add(value);
    print('add----------${value}----------${data.length}--');

    notifyListeners();
  }


  void clear() {
    data.clear();
    notifyListeners();
  }
}
// class BgPainter extends StatelessWidget {
//   const BgPainter({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class AnimValuePainter extends CustomPainter{
  final AnimValues data;

  AnimValuePainter(this.data):super(repaint: data);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero&size, Paint()..color=Colors.grey.withOpacity(0.3));
    canvas.translate(0, size.height);
    canvas.scale(1,-1);
    _drawPoint(data.data, canvas, size);
  }
  void _drawPoint(List<double> values, Canvas canvas, Size size) {
    double stepY = size.height / 11;
    double stepX = size.width / 64;

    List<Offset> drawPoint = [];
    // print(values.length);

    for (int i = 0; i < values.length; i++) {
      drawPoint.add(
          Offset(stepX * (i + 1),
              values[i] * (30)));
    }

    canvas.drawPoints(
        PointMode.points,
        drawPoint,
        Paint()
          ..style = PaintingStyle.stroke..color=Colors.blue
          ..strokeWidth = 2);
  }
  @override
  bool shouldRepaint(covariant AnimValuePainter oldDelegate) {
    return oldDelegate.data!=data;
  }


}