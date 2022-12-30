import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Coordinate {
  final Color axisColor;
  final double strokeWidth;
  final int xScaleCount;
  final double xScale;
  final double yScale;
  final int yScaleCount;

  Coordinate({
    this.axisColor = Colors.black,
    this.strokeWidth = 1,
    this.xScaleCount = 10,
    this.yScaleCount = 10,
    this.xScale = 1,
    this.yScale = 1,
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
  final Paint gridAxisPaint = Paint()..style=PaintingStyle.stroke..color=Colors.grey..strokeWidth=0.5;

  void paint(Canvas canvas, Size size) {
    _drawAxis(canvas, size);

    // 绘制 x 轴文字
    double step = size.width/xScaleCount;

    for(int i=1;i<xScaleCount;i++){
      String value = ((i/xScaleCount)*xScale).toStringAsFixed(1);
      textPainter.text =  TextSpan(
          text: value, style: const TextStyle(fontSize: 12, color: Colors.black));
      textPainter.layout(); // 进行布局
      textPainter.paint(canvas, Offset(i*step-textPainter.size.width/2,5));
      canvas.drawLine(Offset(i*step, 0), Offset(i*step, 5), axisPaint);
      canvas.drawLine(Offset(i*step, 0), Offset(i*step, -size.height), gridAxisPaint);


    }

    // 绘制 y 轴文字
    double stepY = size.height/yScaleCount;
    for(int i=1;i<yScaleCount;i++){
      String value = ((i/yScaleCount)*yScale).toStringAsFixed(1);
      textPainter.text =  TextSpan(
          text: value, style: const TextStyle(fontSize: 12, color: Colors.black));
      textPainter.layout(); // 进行布局
      textPainter.paint(canvas, Offset(-textPainter.size.width-5,- (i*stepY+textPainter.size.height/2)));
      canvas.drawLine(Offset(0,-i*stepY), Offset(5,-i*stepY), axisPaint);

      canvas.drawLine(Offset(0,-i*stepY), Offset(size.width,-i*stepY), gridAxisPaint);
    }

    textPainter.text =  const TextSpan(
        text: '0', style:  TextStyle(fontSize: 12, color: Colors.black));
    textPainter.layout(); // 进行布局
    textPainter.paint(canvas, Offset(-5,5));
  }

  void _drawAxis(Canvas canvas, Size size) {
    Path axisPath = Path();
    axisPath.relativeLineTo(size.width, 0);
    axisPath.relativeLineTo(-10, -4);
    axisPath.moveTo(size.width, 0);
    axisPath.relativeLineTo(-10, 4);
    axisPath.moveTo(0, 0);
    axisPath.relativeLineTo(0, -size.height);
    axisPath.relativeLineTo(-4, 10);
    axisPath.moveTo(0, -size.height);
    axisPath.relativeLineTo(4, 10);
    canvas.drawPath(axisPath, axisPaint);

    textPainter.text = const TextSpan(
        text: 'x 轴', style: TextStyle(fontSize: 12, color: Colors.black));
    textPainter.layout(); // 进行布局
    Size textSize = textPainter.size; // 尺寸必须在布局后获取
    textPainter.paint(canvas, Offset(size.width+5 , -textSize.height/2));
    textPainter.text = const TextSpan(
        text: 'y 轴', style: TextStyle(fontSize: 12, color: Colors.black));
    textPainter.layout(); // 进行布局
    Size textSize2 = textPainter.size; // 尺寸必须在布局后获取
    textPainter.paint(
        canvas,
        Offset(-textSize2.width + textSize2.width / 2,
            -size.height - textSize2.height - 3));
  }
}
