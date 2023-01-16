import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/axis_range.dart';

/// [rate]: 0~1
typedef ScaleFormat = String Function(double rate);

class Coordinate {
  AxisRange range;

  final Color axisColor;
  final double strokeWidth;
  final double xStep;
  final double yStep;

  void move(Offset offset) {
    range = AxisRange(
      minY: range.minY + offset.dy,
      maxY: range.maxY + offset.dy,
      minX: range.minX + offset.dx,
      maxX: range.maxX + offset.dx,
    );
  }

  void scale(double rate) {
    range = AxisRange(
      minY: range.minY * rate,
      maxY: range.maxY * rate,
      minX: range.minX * rate,
      maxX: range.maxX * rate,
    );
  }

  Coordinate({
    this.axisColor = Colors.black,
    this.strokeWidth = 1,
    this.range = const AxisRange(),
    this.xStep = 1,
    this.yStep = 1,
  }) {
    axisPaint
      ..color = axisColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
  }

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  final Paint axisPaint = Paint();
  final Paint gridAxisPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 0.2;

  Offset real(Offset p, Size size) {
    double x = (p.dx - range.minX) / range.xSpan * size.width;
    double y = (p.dy - range.minY) / range.ySpan * size.height;
    return Offset(x, y);
  }

  void paint(Canvas canvas, Size size) {
    // _drawAxis(canvas, size);
    _drawScale(canvas, size);
  }

  void drawAxisLine(Canvas canvas, Size size) {
    canvas.drawLine(
      real(Offset(0, range.minY), size),
      real(Offset(0, range.maxY), size),
      axisPaint,
    );

    canvas.drawLine(
      real(Offset(range.minX, 0), size),
      real(Offset(range.maxX, 0), size),
      axisPaint,
    );
  }

  void _drawScale(Canvas canvas, Size size) {
    List<double> xScales = range.xScales(xStep,size);
    double zeroY = (0 - range.minY) / range.ySpan * size.height;
    double zeroX = (0 - range.minX) / range.xSpan * size.width;
    textPainter.text = TextSpan(
        text: '0',
        style:  TextStyle(fontSize: 12, color: Colors.black));
    textPainter.layout(); // 进行布局
    textPainter.paint(canvas, Offset(zeroX-textPainter.width/2-6, -zeroY+6));

    for (int i = 0; i < xScales.length; i++) {
      double value = xScales[i];
      double offsetX = (value - range.minX) / range.xSpan * size.width;
      if(value == 0){
        continue;
      }
      // 绘制文字
      Color textColor = Colors.black;
      if(zeroY<=25){
        zeroY = 25;
        textColor = Colors.grey;
      }

      if(zeroY>=size.height){
        zeroY = size.height;
        textColor = Colors.grey;
      }

      textPainter.text = TextSpan(
        text: value.toStringAsFixed(2),
        style: TextStyle(fontSize: 12, color: textColor),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
            offsetX - textPainter.size.width / 2,
            5 - zeroY
        ),
      );
      // 绘制网格
      canvas.drawLine(
        Offset(offsetX, 0),
        Offset(offsetX, -size.height),
        gridAxisPaint,
      );
    }

    List<double> yScales = range.yScales(xStep,size);

    for (int i = 0; i < yScales.length; i++) {
      double value = yScales[i];
      if(value == 0){
        continue;
      }
      double offsetY = (value - range.minY) / range.ySpan * size.height;

      Color textColor = Colors.black;
      if(zeroX<=40){
        zeroX = 40;
        textColor = Colors.grey;
      }

      if(zeroX>=size.width){
        zeroX = size.width;
        textColor = Colors.grey;
      }

      textPainter.text = TextSpan(
          text: value.toStringAsFixed(2),
          style:  TextStyle(fontSize: 12, color: textColor));
      textPainter.layout(); // 进行布局
      textPainter.paint(
          canvas,
          Offset(-6 - textPainter.size.width  + zeroX,
              -offsetY - textPainter.size.height / 2));

      canvas.drawLine(
        Offset(0, -offsetY),
        Offset(size.width, -offsetY),
        gridAxisPaint,
      );
    }


  }

}
