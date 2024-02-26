import 'package:flutter/material.dart';

class WrapText {
  final String text;

  WrapText({required this.text});

  TextPainter painter = TextPainter(textDirection: TextDirection.ltr);

  void render(Canvas canvas) {
    painter.text = TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.white,
          height: 1,
          fontSize: 16,
          fontFamily: 'Inconsolata',
        ));
    painter.layout();

    double tWidth = painter.size.width;
    double tHeight = painter.size.height;
    double pdH = 16;
    double pdV = 8;

    Rect rect = Rect.fromLTWH(0, 0, tWidth + pdH * 2, tHeight + pdV * 2);

    // double radius = rect.height / 2;
    double radius = 6;

    RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    canvas.drawRRect(rRect, Paint()..color = Color(0xff1A73E8));
    painter.paint(canvas, Offset.zero.translate(pdH, pdV));
  }
}

class Box {
  final Size size;
  final String text;

  Box({required this.size,required this.text});

  TextPainter painter = TextPainter(textDirection: TextDirection.ltr);

  void render(Canvas canvas) {
    painter.text = TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.white,
          height: 1,
          fontSize: 16,
          fontFamily: 'Inconsolata',
        ));
    painter.layout();

    // double tWidth = painter.size.width;
    // double tHeight = painter.size.height;
    double pdH = 16;
    double pdV = 8;

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    Path path = Path()..addRect(rect);

    // double radius = rect.height / 2;
    double radius = 6;

    RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    Paint fillPaint = Paint()..color = Color(0xff1A73E8);
    // Paint strokePaint = Paint()..color = Colors.black..style=PaintingStyle.stroke;

    // canvas.drawRect(rect, Paint()..color = Colors.black..style=PaintingStyle.stroke);
    canvas.drawRRect(rRect, fillPaint);
    // canvas.drawPath(path, Paint()..color = Colors.black..style=PaintingStyle.stroke);
    painter.paint(canvas, Offset((size.width-painter.size.width)/2, (size.height-painter.size.height)/2));
  }
}