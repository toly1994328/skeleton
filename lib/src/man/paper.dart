import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
class Paper extends CustomPainter{

  ui.Image? image;


  Paper({required this.image});

  @override
  void paint(Canvas canvas, Size size) {

    if(image==null) return;
    canvas.drawImage(image!, Offset.zero, Paint()..color=Colors.black.withOpacity(0.4));

  }

  @override
  bool shouldRepaint(covariant Paper oldDelegate) {
   return oldDelegate.image!=image;
  }

}