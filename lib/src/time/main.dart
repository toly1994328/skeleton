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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
          child:
          StopWatchWidget(
            duration: Duration(minutes: 0, seconds: 24, milliseconds: 850),
            radius: 100,
          )),
    );
  }
}

class StopWatchWidget extends StatelessWidget {
  final double radius;
  final Duration duration;
  final Color? themeColor;
  final TextStyle? textStyle;
  final Color scaleColor;

  const StopWatchWidget({
    Key? key,
    required this.radius,
    required this.duration,
    this.scaleColor = const Color(0xffDADADA),
    this.textStyle,
    this.themeColor
  }) : super(key: key);

  TextStyle get commonStyle => TextStyle(
    fontSize: radius/3,
    fontWeight: FontWeight.w200,
    color: const Color(0xff343434),
    fontFamily: "Mono"
  );

  @override
  Widget build(BuildContext context) {
    TextStyle style = textStyle??commonStyle;
    Color themeColor = this.themeColor??Theme.of(context).primaryColor;
    return CustomPaint(
      painter: StopWatchPainter(
          duration: duration,
          themeColor: themeColor,
          scaleColor: scaleColor,
          textStyle: style),
      size: Size(radius * 2, radius * 2),
    );
  }
}

const double _kScaleWidthRate = 0.4 / 10;
const _kIndicatorRadiusRate = 0.2 / 10;

class StopWatchPainter extends CustomPainter {
  final Duration duration;
  final Color themeColor;
  final Color scaleColor;
  final TextStyle textStyle;

  StopWatchPainter({
    required this.duration,
    required this.themeColor,
    required this.scaleColor,
    required this.textStyle,
  }) {
    indicatorPainter.color = themeColor;
    scalePainter.style = PaintingStyle.stroke;
  }

  final Paint scalePainter = Paint();
  final Paint indicatorPainter = Paint();

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    drawScale(canvas, size);
    final double scaleLineWidth = size.width * _kScaleWidthRate;
    final double indicatorRadius = size.width * _kIndicatorRadiusRate;

    canvas.save();
    int second = duration.inSeconds % 60;
    int milliseconds = duration.inMilliseconds % 1000;
    double radians = (second * 1000 + milliseconds) / (60 * 1000) * 2 * pi;
    canvas.rotate(radians);
    canvas.drawCircle(
        Offset(
          0,
          -size.width / 2 + scaleLineWidth + indicatorRadius,
        ),
        indicatorRadius / 2,
        indicatorPainter);
    canvas.restore();

    drawText(canvas);
  }

  void drawText(Canvas canvas) {
    int minus = duration.inMinutes % 60;
    int second = duration.inSeconds % 60;
    int milliseconds = duration.inMilliseconds % 1000;
    String commonStr =
        '${minus.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")}';
    String highlightStr = ".${(milliseconds ~/ 10).toString().padLeft(2, "0")}";

    textPainter.text = TextSpan(text: commonStr, style: textStyle, children: [
      TextSpan(text: highlightStr, style: textStyle.copyWith(color: themeColor))
    ]);
    textPainter.layout(); // 进行布局
    final double width = textPainter.size.width;
    final double height = textPainter.size.height;
    textPainter.paint(canvas, Offset(-width / 2, -height / 2));
  }

  void drawScale(Canvas canvas, Size size) {
    final double scaleLineWidth = size.width * _kScaleWidthRate;
    for (int i = 0; i < 180; i++) {
      if (i == 90 + 45) {
        scalePainter.color = themeColor;
      } else {
        scalePainter.color = scaleColor;
      }
      canvas.drawLine(Offset(size.width / 2, 0),
          Offset(size.width / 2 - scaleLineWidth, 0), scalePainter);
      canvas.rotate(pi / 180 * 2);
    }
  }

  @override
  bool shouldRepaint(covariant StopWatchPainter oldDelegate) {
    return oldDelegate.duration != duration ||
        oldDelegate.textStyle != textStyle ||
        oldDelegate.themeColor != themeColor||
        oldDelegate.scaleColor != scaleColor;
  }
}
