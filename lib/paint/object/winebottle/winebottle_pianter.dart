
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class WineBottlePainter extends CustomPainter {
  final Animation<double> progress;
  final List<double> bodies;

  WineBottlePainter(this.progress,{required this.bodies}):super(repaint:  progress);

  final Paint _bgPainter = Paint()..color = Colors.grey.withOpacity(0.1);

  final Paint _mainPainter = Paint()
    ..color = const Color(0xff1E1E1E)
    ..style = PaintingStyle.fill;

  final Paint _bodyPainter = Paint()
    ..color = const Color(0xffF19426);


  final Paint _strokePainter = Paint()
    ..color = const Color(0xff1E1E1E)
    ..style = PaintingStyle.stroke;

  static const List<Color> kColors = [
    Color(0xffe99228),
    Color(0xfff2e0ac),
    Color(0xffFF7A90),
    Color(0xffDA425E),
    Color(0xff8E041A),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(Offset.zero & size, _bgPainter);
    double rate = size.width / 52;

    Path path = formBgPath(rate);
    _mainPainter.colorFilter = null;
    _mainPainter.shader = ui.Gradient.linear(
      Offset(26 * rate, -96 * rate),
      Offset(76 * rate, -96 * rate),
      [Color(0xff1E1E1E), Colors.white],
    );
    canvas.drawPath(path, _mainPainter);
    drawBody(canvas,size,path);
    canvas.drawPath(path, _strokePainter..strokeWidth = 2*rate);
    _mainPainter.shader = ui.Gradient.linear(
      Offset(-10.8041 * rate, -1.83331 * rate),
      Offset(19.7355 * rate, -1.83331 * rate),
      [const Color(0xffFAFAFA), Colors.white],
    );
    const ColorFilter opacity = ColorFilter.matrix(<double>[
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, 0.485001, 0,
    ]);
    _mainPainter.colorFilter = opacity;
    Path shine = shinePath(rate);
    canvas.drawPath(shine.shift(Offset(5*(0.5*rate), 30*(0.5*rate))), _mainPainter);
  }

  void drawBody(Canvas canvas,Size size,Path clip){
    canvas.save();
    canvas.clipPath(clip);
    canvas.translate(0,size.height);
    double maxHeight = size.height - size.height*0.2;

    List paths = [];
    double v = 0;
    for(int i= 0;i<bodies.length;i++){
      v += bodies[i];
      Path bodyPath = Path()..addRect(Rect.fromPoints(
        Offset.zero,
        Offset(size.width,(-v*maxHeight*progress.value)),
      ));
      paths.insert(0, bodyPath);
    }

    for(int i= 0;i<paths.length;i++){
      canvas.drawPath(paths[i], _bodyPainter..color=kColors[i]);
    }
    canvas.restore();
  }

  Path shinePath(double rate){
    Path path = Path();
    path.moveTo(29.8462 * rate, 0.0605469 * rate);
    addC(path, '30.3985 0.0605469 30.8462 0.508263 30.8462 1.06055', rate);
    path.lineTo(30.8462 * rate, 29.0605 * rate);
    addC(path, '30.8462 29.6128 30.3985 30.0605 29.8462 30.0605', rate);
    path.relativeLineTo((26.6956-29.8462) * rate, 0);
    addC(path, '26.1433 30.0605 25.6956 29.6128 25.6956 29.0605', rate);
    path.lineTo(25.6956 * rate, 1.06055 * rate);
    addC(path, '25.6956 0.508262 26.1433 0.0605469 26.6956 0.0605469', rate);
    path.lineTo(29.8462 * rate, 0.0605469 * rate);

    path.moveTo(0.972553 * rate, 57.26 * rate);
    addC(path, '0.972553 44.3487 10.3441 38.4055 10.3441 38.4055', rate);
    addC(path, '11.3099 37.8248 12.7407 37.8248 15.1372 39.1911', rate);
    addC(path, '17.5338 40.5573 16.2461 43.5973 14.0284 46.0224', rate);
    addC(path, '10.058 49.6772 10.523 59.1044 10.523 59.1044', rate);
    path.lineTo(10.523* rate,  157.988 * rate);
    addC(path, '10.523 166.8 10.058 169.977 6.23066 169.977', rate);
    addC(path, '2.40333 169.977 0.972553 166.63 0.972553 166.63', rate);
    path.lineTo(0.972553 * rate,  57.26 * rate);
    path.close();
    return path;
  }

  Path formBgPath(double rate){
    Path path = Path();
    path.moveTo(34.8014 * rate, 2.50925 * rate);
    addC(path, '34.8014 2.50925 34.7657 5.42486 34.9084 5.45916', rate);
    addC(path, '36.6211 5.52776 36.407 7.55154 36.3356 9.57531', rate);
    addC(path, '36.2643 11.2561 35.3366 11.359 35.3366 11.359', rate);
    path.lineTo(36.2286 * rate, 41.4677 * rate);
    addC(path, '36.2286 41.4677 37.3347 49.4255 42.9363 53.3016', rate);
    addC(path, '48.538 57.1776 50.9999 63.8664 50.9999 73.3335', rate);
    path.lineTo(50.9999 * rate, 187.248 * rate);
    addC(path, '50.9999 187.248 51.107 195 26.2383 195', rate);
    addC(path, '3.54613 195 1.11993 188.689 1.11993 188.689', rate);
    path.lineTo(1.08425 * rate, 77.5869 * rate);
    addC(path, '1.08425 77.5869 -0.449976 61.0194 9.57597 53.0958', rate);
    addC(path, '12.9299 49.4255 17.1757 46.407 16.7476 33.7156', rate);
    path.lineTo(16.8546 * rate, 11.6334 * rate);
    addC(path, '16.1053 11.1245 15.6754 10.2851 15.7129 9.4038', rate);
    addC(path, '15.7129 7.82595 15.6415 6.24809 15.6415 6.24809', rate);
    addC(path, '15.6415 6.24809 15.7129 5.21905 17.1757 5.21905', rate);
    addC(path, '17.2471 3.98421 17.1757 2.40635 17.1757 2.40635', rate);
    addC(path, '17.1757 2.40635 17.0687 1 19.6019 1', rate);
    path.lineTo(32.7677 * rate, 1 * rate);
    addC(path, '32.7677 1 34.8728 1 34.8014 2.50925', rate);
    path.close();
    return path;
  }


  void addC(
    Path path,
    String dataStr,
    double rate,
  ) {
    //
    List<double> data = dataStr.split(" ").map(double.parse).toList();
    path.cubicTo(
      data[0] * rate,
      data[1] * rate,
      data[2] * rate,
      data[3] * rate,
      data[4] * rate,
      data[5] * rate,
    );
  }

  @override
  bool shouldRepaint(covariant WineBottlePainter oldDelegate) {
    return bodies!=oldDelegate.bodies;
  }
}
