import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/coo_config.dart';

/// [rate]: 0~1
typedef ScaleFormat = String Function(double rate);

class Coordinate {
  AxisRange range;

  final Color axisColor;
  final double strokeWidth;
  final int xScaleCount;
  final int yScaleCount;

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
    this.xScaleCount = 10,
    this.yScaleCount = 10,
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
    ..strokeWidth = 0.5;

  void paint(Canvas canvas, Size size) {
    _drawAxis(canvas, size);
    _drawScale(
      canvas,
      size,
    );
  }

  void _drawScale(Canvas canvas, Size size) {
    double stepX = (range.xSpan / xScaleCount);
    for(int i =0;i<=xScaleCount;i++){
      double value = range.minX+stepX*i;
      double offsetX = (value - range.minX) / range.xSpan * size.width;
      textPainter.text = TextSpan(
        text: value.toStringAsFixed(2),
        style: const TextStyle(fontSize: 12, color: Colors.black),
      );
      textPainter.layout();
      // 绘制文字
      textPainter.paint(
        canvas,
        Offset(offsetX - textPainter.size.width / 2, 5),
      );
      // 绘制网格
      canvas.drawLine(
        Offset(offsetX, 0),
        Offset(offsetX, -size.height),
        gridAxisPaint,
      );
    }

    double stepY = (range.ySpan / xScaleCount);
    for(int i =0;i<=yScaleCount;i++){
      double value = range.minY+stepY*i;
      double offsetY = (value - range.minY) / range.ySpan * size.height;
      textPainter.text = TextSpan(
          text: value.toStringAsFixed(2),
          style: const TextStyle(fontSize: 12, color: Colors.black));
      textPainter.layout(); // 进行布局
      textPainter.paint(
          canvas,
          Offset(-6 - textPainter.size.width,
              -offsetY - textPainter.size.height / 2));

      canvas.drawLine(
        Offset(0, -offsetY),
        Offset(size.height, -offsetY),
        gridAxisPaint,
      );
    }
  }

  void _drawAxis(Canvas canvas, Size size) {
    // x 轴
    Path axisPath = Path();
    axisPath.relativeLineTo(size.width + 15, 0);
    axisPath.relativeLineTo(-10, -4);
    axisPath.moveTo(size.width + 15, 0);
    axisPath.relativeLineTo(-10, 4);

    // y 轴
    axisPath.moveTo(0, 0);
    axisPath.relativeLineTo(0, -size.height - 15);
    axisPath.relativeLineTo(-4, 10);
    axisPath.moveTo(-0, -size.height - 15);
    axisPath.relativeLineTo(4, 10);
    canvas.drawPath(axisPath, axisPaint);

    textPainter.text = const TextSpan(
        text: 'x 轴', style: TextStyle(fontSize: 12, color: Colors.black));
    textPainter.layout(); // 进行布局
    Size textSize = textPainter.size; // 尺寸必须在布局后获取
    textPainter.paint(canvas, Offset(size.width + 5, -textSize.height - 5));
    textPainter.text = const TextSpan(
        text: 'y 轴', style: TextStyle(fontSize: 12, color: Colors.black));
    textPainter.layout(); // 进行布局
    Size textSize2 = textPainter.size; // 尺寸必须在布局后获取
    textPainter.paint(
      canvas,
      Offset(textSize2.width / 2, -size.height - (textSize2.height + 5)),
    );
  }
}
