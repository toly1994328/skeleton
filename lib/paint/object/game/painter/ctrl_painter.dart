import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 机体的外壳
class CtrlPainter extends CustomPainter{
  final Paint _screenPainter = Paint();
  final Paint _ctrlPainter = Paint();


  @override
  void paint(Canvas canvas, Size size) {
    final Size shellSize = Size(800, 1752);
    double rate = size.width/shellSize.width;
    final Offset directionCtrlCenter = Offset(248*rate, 1164*rate);
    final double directionCtrlRadius = 182*rate;
    final Color ctrlColor = Color(0xffffc905);

    _ctrlPainter.color = ctrlColor;

    double directionRadius = 107/2*rate;
    double directionCenterLen = 102*rate;
    Path topCtrlPath = Path()..addOval(Rect.fromCircle(center: directionCtrlCenter.translate(0, -directionCenterLen), radius: directionRadius));
    canvas.drawShadow(topCtrlPath, Colors.black, 4, false);
    canvas.drawPath(topCtrlPath, _ctrlPainter);

    Path bottomCtrlPath = Path()..addOval(Rect.fromCircle(center: directionCtrlCenter.translate(0, directionCenterLen), radius: directionRadius));
    canvas.drawShadow(bottomCtrlPath, Colors.black, 4, false);
    canvas.drawPath(bottomCtrlPath, _ctrlPainter);

    Path rightCtrlPath = Path()..addOval(Rect.fromCircle(center: directionCtrlCenter.translate(directionCenterLen,0 ), radius: directionRadius));
    canvas.drawShadow(rightCtrlPath, Colors.black, 4, false);
    canvas.drawPath(rightCtrlPath, _ctrlPainter);

    Path leftCtrlPath = Path()..addOval(Rect.fromCircle(center: directionCtrlCenter.translate(-directionCenterLen,0 ), radius: directionRadius));
    canvas.drawShadow(leftCtrlPath, Colors.black, 4, false);
    canvas.drawPath(leftCtrlPath, _ctrlPainter);

    // canvas.drawCircle(directionCtrlCenter, directionCtrlRadius,_ctrlPainter);

    final Offset rotaryCtrlCenter = Offset(632*rate, 1164*rate);
    final Size rotaryCtrlSize = Size(218*rate, 153*rate);
    Rect rotaryCtrlZone = Rect.fromCenter(center:rotaryCtrlCenter, width:rotaryCtrlSize.width, height:rotaryCtrlSize.height);
    RRect rotaryCtrlRRect = RRect.fromRectAndRadius(rotaryCtrlZone, Radius.circular(rotaryCtrlSize.height/2));
    // _ctrlPainter.color = ctrlColor;
    Path rotaryCtrlPath = Path()..addRRect(rotaryCtrlRRect);

    canvas.drawShadow(rotaryCtrlPath, Colors.black, 2, false);
    canvas.drawPath(rotaryCtrlPath, _ctrlPainter);
    // canvas.drawRRect(rotaryCtrlRRect,_ctrlPainter);

    final Offset onStart = Offset(364*rate, 881*rate);
    final Size onSize = Size(111*rate, 91*rate);
    Rect onCtrlZone = Rect.fromLTWH(onStart.dx,onStart.dy,onSize.width,onSize.height);
    RRect onCtrlRRect = RRect.fromRectAndRadius(onCtrlZone, Radius.circular(onCtrlZone.height/2));

    Path onCtrlPath = Path()..addRRect(onCtrlRRect.inflate(-4));
    // Path rotaryCtrlPath2 = Path()..addRRect(rotaryCtrlRRect);
    canvas.drawShadow(onCtrlPath, Colors.black, 2, false);
    canvas.drawPath(onCtrlPath, _ctrlPainter);

    // final Offset ctrl3Start = Offset(364*rate, 881*rate);
    // final Size ctrl3Size = Size(354*rate, 91*rate);
    // Rect ctrl3Zone = Rect.fromLTWH(ctrl3Start.dx, ctrl3Start.dy, ctrl3Size.width, ctrl3Size.height);
    // _ctrlPainter.color = screenColor;
    // canvas.drawRect(ctrl3Zone, _ctrlPainter);


    Offset p0 = Offset(501*rate, 960*rate);
    Offset p1 = Offset(573*rate, 960*rate);
    Offset p2 = Offset(536*rate, 893*rate);
    Path resetCtrlPath = Path()
      ..moveTo(p0.dx, p0.dy )
      ..lineTo(p1.dx, p1.dy )
      ..lineTo(p2.dx, p2.dy )..close();
    canvas.drawShadow(resetCtrlPath, Colors.black, 2, false);

    canvas.drawPath(resetCtrlPath,  _ctrlPainter);

    Path startCtrlPath = onCtrlPath.shift(Offset(238*rate, 0));
    canvas.drawShadow(startCtrlPath, Colors.black, 2, false);
    canvas.drawPath(startCtrlPath, _ctrlPainter);

  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}