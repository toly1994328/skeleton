import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnowPainter extends CustomPainter {
  final Paint _bgPainter = Paint()..color = Colors.grey.withOpacity(0.1);
  final Paint _mainPainter = Paint()
    ..color = const Color(0xff292869)
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(Offset.zero & size, _bgPainter);
    canvas.translate(size.width / 2, size.height / 2);
    // canvas.drawCircle(Offset.zero, 4, _mainPainter);
    double rate = 1 / 133 * size.width / 2;
    drawInner(canvas,rate);

    Path p = Path()
      ..relativeLineTo(35*rate, -8*rate)
      ..relativeLineTo(7*rate, 7*rate)
      ..relativeLineTo(-7*rate, 7*rate)..close()
    ..moveTo(44*rate, 0)
    ..relativeLineTo(6*rate, -6*rate)
      ..relativeLineTo(46*rate, 2*rate)
    ..relativeLineTo(12*rate, 4*rate)
    ..relativeLineTo(-12*rate, 4*rate)
    ..relativeLineTo(-46*rate, 2*rate)
    ..lineTo(44*rate, 0)
      ..addOval(Rect.fromCircle(center: Offset(
        44*rate,-11*rate
      ),radius: 4*rate))
      ..addOval(Rect.fromCircle(center: Offset(
          44*rate,11*rate
      ),radius: 4*rate))
    ;

    Path p2 = Path()
      ..moveTo(69*rate, 0)
      ..relativeLineTo(36*rate, -34*rate)
      ..lineTo(83*rate, 0)
      ..relativeLineTo(28*rate, 34*rate)
      ..close()
    ;

    Path r = Path.combine(PathOperation.union, p, p2);

    // canvas.drawPath(p2.shift(Offset(24*rate, 0)), _mainPainter);
    for(int i=0;i<8;i++){
      canvas.rotate(2*pi/8*i);
      canvas.save();
      // canvas.rotate(23/180*pi);
      // canvas.translate(18*rate, 0);
      canvas.drawPath(r.shift(Offset(24*rate, 0)), _mainPainter);
      // canvas.drawPath(result, _mainPainter);
      canvas.restore();
    }
  }

  void drawInner(Canvas canvas,double rate){
    Path p1 = Path()
      ..lineTo(0, -17*rate)
      ..relativeLineTo(45*rate, 7*rate)
      ..relativeLineTo(-30*rate, 4*rate)..close();
    Path result = p1;

    for(int i=1;i<8;i++){
      Path path = p1.transform(Matrix4.rotationZ(2*pi/8*i).storage);
      result = Path.combine(PathOperation.union, path, result);
    }

    Path reflectY = result.transform(Matrix4.diagonal3Values(1, -1, 1).storage);
    result = Path.combine(PathOperation.union, result, reflectY);
    Path circle = Path()..addOval(Rect.fromCircle(center: Offset.zero, radius: 15*rate));

    canvas.drawPath(Path.combine(PathOperation.difference, result, circle), _mainPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Path combineAll(List<Path> paths,{PathOperation operation=PathOperation.union}){
    if(paths.isEmpty) return Path();
    if(paths.length<=1) return paths.first;
    Path result = paths.first;
    for(int i = 1;i<paths.length;i++){
      result = Path.combine(operation, paths[i], result);
    }
    return result;
  }

}
