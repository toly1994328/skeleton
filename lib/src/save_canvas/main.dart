import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';




class PicManPainter extends CustomPainter {
  final Color color; // 颜色
  final double angle; // 角度(与x轴交角 角度制)

  Paint _paint = Paint();

  PicManPainter({this.color = Colors.yellowAccent, this.angle = 30});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size); //剪切画布
    createPicture(canvas,size);
  }

  Picture? picture;

  void createPicture(Canvas c ,Size size){
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    final double radius = size.width / 2;
    canvas.translate(radius, size.height / 2);

    _drawHead(canvas, size);
    _drawEye(canvas, radius);
    picture = recorder.endRecording();

    c.drawPicture(picture!);
  }

  //绘制头
  void _drawHead(Canvas canvas, Size size) {
    var rect = Rect.fromCenter(
        center: Offset(0, 0), height: size.width, width: size.height);
    var a = angle / 180 * pi;
    canvas.drawArc(rect, a, 2 * pi - a.abs() * 2, true, _paint..color = color);
  }

  //绘制眼睛
  void _drawEye(Canvas canvas, double radius) {
    canvas.drawCircle(Offset(radius * 0.15, -radius * 0.6), radius * 0.12,
        _paint..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant PicManPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.angle != angle;
}