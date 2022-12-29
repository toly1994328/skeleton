import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WindmillWidget(),
    );
  }
}

class WindmillWidget extends StatefulWidget {
  const WindmillWidget({Key? key}) : super(key: key);

  @override
  State<WindmillWidget> createState() => _WindmillWidgetState();
}

class _WindmillWidgetState extends State<WindmillWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: Duration(seconds: (3 * 1.5).toInt()),
  );
  late Animation<double> rotate;

  @override
  void initState() {
    rotate = Tween<double>(begin: 0, end: 3 * 2 * pi)
        .animate(CurveTween(curve: Curves.easeIn).animate(_ctrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: GestureDetector(
        onTap: () async {
          await _ctrl.forward(from: 0);
        },
        child: Container(
          alignment: Alignment.center,
          child: Wrap(
            spacing: 20,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // CustomPaint(
              //   size: const Size(100, 100),
              //   painter: WindmillPainter(rotate),
              // ),
              CustomPaint(
                size: const Size(600, 600),
                painter: WindmillPainter(rotate),
              ),
              // CustomPaint(
              //   size: const Size(250, 250),
              //   painter: WindmillPainter(rotate),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class WindmillPainter extends CustomPainter {
  final Animation<double> rotate;

  WindmillPainter(this.rotate) : super(repaint: rotate);

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colors = const [
      Color(0xffE74437),
      Color(0xffFBBD19),
      Color(0xff3482F0),
      Color(0xff30A04C)
    ];
    canvas.translate(size.width / 2, size.height / 2);
    double d = size.width * 0.4;
    canvas.rotate(rotate.value);
    Paint paint = Paint();
    for (Color color in colors) {
      Path path1 = Path()
        ..moveTo(0, -d * 46 / 203)
        ..lineTo(0, -d * 203 / 203)
        ..lineTo(102 / 203 * d, -102 / 203 * d)
        ..lineTo(12 / 203 * d, -12 / 203 * d)
        ..close();
      canvas.drawPath(path1, paint..color = color..style=PaintingStyle.fill);

      Path path2 = Path()
        ..moveTo(12 / 203 * d, -12 / 203 * d)
        ..lineTo(102 / 203 * d, -102 / 203 * d)
        ..lineTo(102 / 203 * d, 0)
        ..lineTo(46 / 203 * d, 0)
        ..close();
      canvas.drawPath(path2, paint..color = color.withOpacity(0.2)..style=PaintingStyle.fill);

      // Path path3 = Path()
      //   ..moveTo(0, -d)..relativeQuadraticBezierTo(d*0.48, -d*0.22, d, d);
      // canvas.drawPath(path3, paint..color = color..style=PaintingStyle.stroke);
      canvas.rotate(pi / 2);
    }
  }

  void draw1(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    double d = size.width * 0.4;
    Path path = Path()
      ..addArc(
        Rect.fromCenter(center: Offset(d / 2, 0), width: d, height: d),
        0,
        pi,
      );
    List<Color> colors = const [
      Color(0xffE74437),
      Color(0xffFBBD19),
      Color(0xff3482F0),
      Color(0xff30A04C)
    ];
    Paint paint = Paint();
    for (Color color in colors) {
      canvas.drawPath(path, paint..color = color);
      canvas.rotate(pi / 2);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
