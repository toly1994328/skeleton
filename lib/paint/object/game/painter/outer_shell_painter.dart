import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 机体的外壳
class OuterShellPainter extends CustomPainter {
  final Paint _bgPainter = Paint()..color = Colors.grey.withOpacity(0.1);
  final Paint _screenPainter = Paint();
  final Paint _ctrlPainter = Paint();

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  @override
  void paint(Canvas canvas, Size size) {
    _bgPainter.color = Color(0xff80b0d4);
    final Size shellSize = Size(800, 1752);
    double rate = size.width / shellSize.width;
    final double radius = 30 * rate;
    final Offset screenStart = Offset(142 * rate, 133 * rate);
    final Size screenSize = Size(518 * rate, 665 * rate);
    final Color screenColor = Color(0xff685c44);

    Rect zone = Offset.zero & size;

    canvas.drawRRect(
        RRect.fromRectAndRadius(zone, Radius.circular(radius)), _bgPainter);

    Rect screenZone = Rect.fromLTWH(
        screenStart.dx, screenStart.dy, screenSize.width, screenSize.height);
    _screenPainter.color = screenColor;
    canvas.drawRect(screenZone, _screenPainter);

    drawButtonsBackground(canvas, rate);

    Offset offset = Offset(394 * rate, 1711 * rate);
    double r = 10 * rate;
    Path circlePath = Path()
      ..addOval(Rect.fromCircle(center: offset, radius: r));
    // Path rotaryCtrlPath2 = Path()..addRRect(rotaryCtrlRRect);
    List<BoxShadow> shadows = [
      BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 2,
          blurStyle: BlurStyle.solid)
    ];

    for (int i = 0; i < 13; i++) {
      for (int j = 0; j < 13 - i; j++) {
        Path path = circlePath.shift(Offset(j * r * 3 + i * r * 3, -i * r * 3));
        drawShadows(canvas, path, shadows);
        canvas.drawPath(path, _bgPainter);
      }
    }
  }

  void drawButtonsBackground(Canvas canvas, double rate) {
    final TextStyle style = TextStyle(
      letterSpacing: 2.5,
      shadows: [
        BoxShadow(
            color: Colors.black, blurRadius: 1, blurStyle: BlurStyle.solid)
      ],
      fontSize: 30 * rate,
      color: _bgPainter.color,
    );
    final TextStyle smallStyle = TextStyle(
      letterSpacing: 2,
      shadows: [
        BoxShadow(
            color: Colors.black, blurRadius: 1, blurStyle: BlurStyle.solid)
      ],
      fontSize: 24 * rate,
      color: _bgPainter.color,
    );

    final Offset directionCtrlCenter = Offset(248 * rate, 1164 * rate);
    final double directionCtrlRadius = 182 * rate;
    final Color ctrlColor = Color(0xffffc905);

    _ctrlPainter.color = ctrlColor;

    Path directionCtrlPath = Path()
      ..addOval(Rect.fromCircle(
          center: directionCtrlCenter, radius: directionCtrlRadius));
    canvas.drawShadow(directionCtrlPath, _bgPainter.color, 6 * rate, true);
    canvas.drawPath(directionCtrlPath, _bgPainter);
    // canvas.drawCircle(directionCtrlCenter, directionCtrlRadius,_ctrlPainter);

    final Offset rotaryCtrlCenter = Offset(632 * rate, 1164 * rate);
    final Size rotaryCtrlSize = Size(218 * rate + 8, 153 * rate + 8);
    Rect rotaryCtrlZone = Rect.fromCenter(
        center: rotaryCtrlCenter,
        width: rotaryCtrlSize.width,
        height: rotaryCtrlSize.height);
    RRect rotaryCtrlRRect = RRect.fromRectAndRadius(
        rotaryCtrlZone, Radius.circular(rotaryCtrlSize.height / 2));
    // _ctrlPainter.color = ctrlColor;
    // canvas.drawRRect(rotaryCtrlRRect,_ctrlPainter);
    Path rotaryCtrlPath = Path()..addRRect(rotaryCtrlRRect);
    textPainter.text = TextSpan(text: 'Rotary', style: style);
    textPainter.layout(); // 进行布局
    textPainter.paint(canvas, Offset(568 * rate, 1031 * rate));
    // Path rotaryCtrlPath2 = Path()..addRRect(rotaryCtrlRRect);

    textPainter.text = TextSpan(text: 'On/Off', style: smallStyle);
    textPainter.layout(); // 进行布局
    textPainter.paint(canvas, Offset(374 * rate, 975 * rate));

    textPainter.text = TextSpan(text: 'Reset', style: smallStyle);
    textPainter.layout(); // 进行布局
    textPainter.paint(canvas, Offset(495 * rate, 975 * rate));

    textPainter.text = TextSpan(text: 'Start/Pause', style: TextStyle(
      letterSpacing: 0.2,
      shadows: [
        BoxShadow(
            color: Colors.black, blurRadius: 1, blurStyle: BlurStyle.solid)
      ],
      fontSize: 24 * rate,
      color: _bgPainter.color,
    ));
    textPainter.layout(); // 进行布局
    textPainter.paint(canvas, Offset(604 * rate, 975 * rate));

    drawShadows(canvas, rotaryCtrlPath, [
      BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 2,
          blurStyle: BlurStyle.solid)
    ]);

    // canvas.drawShadow(rotaryCtrlPath, _bgPainter.color,6*rate,true);
    canvas.drawPath(rotaryCtrlPath, _bgPainter);

    final Offset ctrl3Start = Offset(364 * rate, 881 * rate);
    final Size ctrl3Size = Size(354 * rate, 91 * rate);
    Rect ctrl3Zone = Rect.fromLTWH(
        ctrl3Start.dx, ctrl3Start.dy, ctrl3Size.width, ctrl3Size.height);
    // _ctrlPainter.color = screenColor;
    // canvas.drawRect(ctrl3Zone, _ctrlPainter);

    final Offset onStart = Offset(364 * rate, 881 * rate);
    final Size onSize = Size(111 * rate, 91 * rate);
    Rect onCtrlZone =
        Rect.fromLTWH(onStart.dx, onStart.dy, onSize.width, onSize.height);
    RRect onCtrlRRect = RRect.fromRectAndRadius(
        onCtrlZone, Radius.circular(onCtrlZone.height / 2));

    Path onCtrlPath = Path()..addRRect(onCtrlRRect);
    // Path rotaryCtrlPath2 = Path()..addRRect(rotaryCtrlRRect);

    drawShadows(canvas, onCtrlPath, [
      BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 2,
          blurStyle: BlurStyle.solid)
    ]);
    canvas.drawPath(onCtrlPath, _bgPainter);

    Offset p0 = Offset(491 * rate, 971 * rate);
    Offset p1 = Offset(586 * rate, 971 * rate);
    Offset p2 = Offset(536 * rate, 881 * rate);
    Path resetCtrlPath = Path()
      ..moveTo(p0.dx, p0.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..close();
    drawShadows(canvas, resetCtrlPath, [
      BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 2,
          blurStyle: BlurStyle.solid)
    ]);
    canvas.drawPath(resetCtrlPath, _bgPainter);

    Path startCtrlPath = onCtrlPath.shift(Offset(238 * rate, 0));
    drawShadows(canvas, startCtrlPath, [
      BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 2,
          blurStyle: BlurStyle.solid)
    ]);
    canvas.drawPath(startCtrlPath, _bgPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawShadows(Canvas canvas, Path path, List<BoxShadow> shadows) {
    for (final BoxShadow shadow in shadows) {
      final Paint shadowPainter = shadow.toPaint();
      if (shadow.spreadRadius == 0) {
        canvas.drawPath(path.shift(shadow.offset), shadowPainter);
      } else {
        Rect zone = path.getBounds();
        double xScale = (zone.width + shadow.spreadRadius) / zone.width;
        double yScale = (zone.height + shadow.spreadRadius) / zone.height;
        Matrix4 m4 = Matrix4.identity();
        m4.translate(zone.width / 2, zone.height / 2);
        m4.scale(xScale, yScale);
        m4.translate(-zone.width / 2, -zone.height / 2);
        canvas.drawPath(
            path.shift(shadow.offset).transform(m4.storage), shadowPainter);
      }
    }
  }
}
