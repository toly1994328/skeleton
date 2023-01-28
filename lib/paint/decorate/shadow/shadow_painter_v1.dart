import 'dart:math';

import 'package:flutter/material.dart';

class ShadowPainterV1 extends CustomPainter{

  final Paint _mainPainter = Paint()
    ..color = const Color(0xff292869)
    ..style = PaintingStyle.fill;

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    // _mainPainter.maskFilter = MaskFilter.blur(BlurStyle.normal, Shadow.convertRadiusToSigma(14));
    // _mainPainter.color=Colors.black.withOpacity(0.1);

    canvas.translate(-350, 0);
    drawBox(canvas,2,);
    canvas.translate(150, 0);
    drawBox(canvas,5,);
    canvas.translate(150, 0);
    drawBox(canvas,6,);
    canvas.translate(150, 0);
    drawBox(canvas,9,);
    canvas.translate(150, 0);
    // ElementUI 阴影
    BoxDecoration element = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color:const Color(0xffebeef5)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0,2),
          blurRadius: 12,
          spreadRadius: 0,
        )
      ],
    );
    final ImageConfiguration configuration = ImageConfiguration(
      size: Size(100,60),
    );
    element.createBoxPainter().paint(canvas, Offset.zero, configuration);
  }

  void drawBox(Canvas canvas,double elevation){
    Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Rect.fromPoints(
          Offset.zero,
          const Offset(100,60),
        ), const Radius.circular(8)),
      );
    canvas.drawShadow(path, Colors.blue.withOpacity(0.2), elevation, false);
    Paint whitePaint =  Paint()..color=Colors.white;
    canvas.drawPath(path,whitePaint);

    textPainter.text = TextSpan(
        text: 'elevation: $elevation',
        style:  TextStyle(fontSize: 12, color: Colors.black));
    textPainter.layout(); // 进行布局
    textPainter.paint(canvas, Offset(10,-30));

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Path snowPath(double rate){
    Path innerp1 = Path()
      ..lineTo(0, -17 * rate)
      ..relativeLineTo(45 * rate, 7 * rate)
      ..relativeLineTo(-30 * rate, 4 * rate)
      ..close();
    Path result = innerp1;

    for (int i = 1; i < 8; i++) {
      Path path = innerp1.transform(Matrix4.rotationZ(2 * pi / 8 * i).storage);
      result = Path.combine(PathOperation.union, path, result);
    }

    Path reflectY = result.transform(Matrix4.diagonal3Values(1, -1, 1).storage);
    result = Path.combine(PathOperation.union, result, reflectY);
    Path circle = Path()
      ..addOval(Rect.fromCircle(center: Offset.zero, radius: 15 * rate));

    result = Path.combine(PathOperation.difference, result, circle);

    Path p1 = Path()
      ..relativeLineTo(35 * rate, -8 * rate)
      ..relativeLineTo(7 * rate, 7 * rate)
      ..relativeLineTo(-7 * rate, 7 * rate)
      ..close()
      ..moveTo(44 * rate, 0)
      ..relativeLineTo(6 * rate, -6 * rate)
      ..relativeLineTo(46 * rate, 2 * rate)
      ..relativeLineTo(12 * rate, 4 * rate)
      ..relativeLineTo(-12 * rate, 4 * rate)
      ..relativeLineTo(-46 * rate, 2 * rate)
      ..lineTo(44 * rate, 0);

    Path p2 = Path()
      ..relativeLineTo(35 * rate, -8 * rate)
      ..relativeLineTo(7 * rate, 7 * rate)
      ..relativeLineTo(-7 * rate, 7 * rate)
      ..close()
      ..moveTo(44 * rate, 0);

    Matrix4 matrix4 = Matrix4.identity();

    matrix4.scale(0.6);
    matrix4.translate(21 * rate, 0);
    matrix4.rotateZ(pi);
    matrix4.translate(-21 * rate, 0);

    matrix4 = Matrix4.rotationZ(-45 * pi / 180).multiplied(matrix4);
    matrix4 = Matrix4.translationValues(42 * rate, -8 * rate, 0).multiplied(matrix4);
    p2 = p2.transform(matrix4.storage);
    // canvas.drawPath(p2, _mainPainter..color=Colors.red);

    Matrix4 reflexY = Matrix4.diagonal3Values(1, -1, 1);
    p2 = Path.combine(
      PathOperation.union,
      p2,
      p2.transform(reflexY.storage),
    );
   //
    Path p3 = Path()
      ..moveTo(69 * rate, 0)
      ..relativeLineTo(36 * rate, -34 * rate)
      ..lineTo(83 * rate, 0)
      ..relativeLineTo(36* rate - (83 - 69) * rate, 34 * rate)
      ..close();

   Path outResult = combineAll([p1, p2, p3]);

   //
    List<Path> paths = [];
    Matrix4 tranM4 = Matrix4.translationValues(24 * rate, 0, 0);
    for (int i = 0; i < 8; i++) {
      double rotate = 2 * pi / 8 * i;
      Matrix4 matrix4 = Matrix4.rotationZ(rotate)..multiply(tranM4);
      paths.add(outResult.transform(matrix4.storage));
    }
    outResult = combineAll(paths);

    return combineAll([result,outResult]);
  }

  Path combineAll(List<Path> paths,
      {PathOperation operation = PathOperation.union}) {
    if (paths.isEmpty) return Path();
    if (paths.length <= 1) return paths.first;
    Path result = paths.first;
    for (int i = 1; i < paths.length; i++) {
      result = Path.combine(operation, paths[i], result);
    }
    return result;
  }
}