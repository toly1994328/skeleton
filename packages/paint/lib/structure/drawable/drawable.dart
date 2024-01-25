import 'dart:ui';

import 'package:dash_painter/dash_painter.dart';
import 'package:flutter/material.dart';

abstract class Drawable {
  Rect get viewPort;

  Path get path;

  void draw(Canvas canvas);
}

class BoxDrawable extends Drawable {
  final Rect zone;
  final bool dash;
  final String value;
  TextPainter _textPainter = TextPainter(
      textDirection: TextDirection.ltr, textAlign: TextAlign.center);

  BoxDrawable(this.zone, this.value,{this.dash=false});

  @override
  Path get path {
    Path _path = Path();
    _path..addRect(viewPort);
    return _path;
  }

  @override
  // TODO: implement viewPort
  Rect get viewPort => zone;

  @override
  void draw(Canvas canvas) {
    Paint fillPaint = Paint()..color = Color(0xffEFEFEF);
    canvas.drawPath(path, fillPaint);
    Paint painter = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 1;
    canvas.drawPath(path, painter);

    Color textColor = Colors.black;
    _textPainter.text = TextSpan(
        text: value,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold));
    _textPainter.layout();
    Size textSize = _textPainter.size;
    _textPainter.paint(canvas,
        viewPort.center - Offset(textSize.width / 2, textSize.height / 2));
  }
}

class StackDrawable extends Drawable {
  final Size size;
  final String name;
  TextPainter _textPainter = TextPainter(
      textDirection: TextDirection.ltr, textAlign: TextAlign.center);

  List<BoxDrawable> boxes = [];

  StackDrawable(this.size, this.name);

  void add(BoxDrawable box){
    boxes.add(box);
  }

  @override
  void draw(Canvas canvas) {
    for (int i = 0; i <boxes.length; i++) {
      boxes[i].draw(canvas);
    }
    Paint painter = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 1;

    canvas.drawPath(path, painter);
    _textPainter.text = TextSpan(
        text: name,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold));
    _textPainter.layout();
    Size textSize = _textPainter.size;
    _textPainter.paint(canvas, Offset((viewPort.width-textSize.width)/2, textSize.height/2));
  }

  @override
  // TODO: implement path
  Path get path {
    Path path = Path();
    path..moveTo(0, -size.height)
      ..relativeLineTo(0, size.height)
      ..relativeLineTo(size.width, 0)
      ..relativeLineTo(0, -size.height);
    // for(int i=0;i<boxes.length;i++){
    //   path.addPath(boxes[i].path, Offset.zero);
    // }
    return path;
  }

  @override
  Rect get viewPort => Offset.zero&size;
}
