import 'package:flutter/material.dart';
import 'package:skeleton/src/arrow_path/arrow/arrow_path.dart';
import 'package:skeleton/src/arrow_path/arrow/port_path.dart';

class PortPathPainter extends CustomPainter {

  final Paint _arrowPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth=1
    ..color = const Color(0xff2503F9);

  var _textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Size zoneSize = const Size(120, 120);
    Rect zone = Rect.fromCenter(center: Offset.zero,
        width: zoneSize.width,
        height: zoneSize.height);
    drawHelp(canvas, zone);


    // PortPathBuilder pathBuilder = const TrianglePortPath.threeAngle(rate: 0.75);
    // StokePathMixin stokePath = const TrianglePortPath.threeAngle(rate: 0.75);
    // StokePathMixin stokePath = const RhombusPortPath();
    StokePathMixin stokePath = const CirclePortPath();
    // PortPathBuilder pathBuilder = const TrianglePortPath.custom();
    // PortPathBuilder pathBuilder = const HalfTrianglePortPath(lineWidth: 10);
    // PortPathBuilder pathBuilder = const HalfTriangleLinePortPath(lineWidth: 15);
    // PortPathBuilder pathBuilder = const CirclePortPath();
    // PortPathBuilder pathBuilder = const RhombusPortPath();

    // PortPathBuilder pathBuilder = const RhombusPortPath(lowRate: 0);
    PortPathBuilder pathBuilder = StokeHandler(child: stokePath,lineWidth: 15);
    Path result = pathBuilder.fromPathByRect(zone);



    //
    // canvas.save();
    // _arrowPaint.strokeWidth = 28;
    // canvas.drawCircle(Offset(6.75,-0.0), 5, Paint());
    // canvas.drawCircle(Offset(6.75,-0.0), 6.75+75, Paint()..style=PaintingStyle.stroke);

    canvas.drawPath(result, _arrowPaint);
    // canvas.restore();

    _textPainter.text= TextSpan(
        text: pathBuilder.debugLabel,
        style: const TextStyle(fontSize: 20,color: Colors.black));
    _textPainter.layout(); // 进行布局
    _textPainter.paint(canvas, Offset(-_textPainter.size.width/2,80)); // 进行绘制

    canvas.save();
    canvas.translate(-zoneSize.width-40, 0);
    _arrowPaint.style = PaintingStyle.fill;
    _arrowPaint.color = const Color(0x662503F9);
    drawHelp(canvas, zone);
    canvas.drawPath(result, _arrowPaint);
    canvas.restore();

    canvas.save();

    canvas.translate(zoneSize.width+40, 0);
    _arrowPaint.color = const Color(0xff2503F9);
    _arrowPaint.style = PaintingStyle.fill;

    canvas.drawPath(result, _arrowPaint);
    canvas.restore();

    // PortPathBuilder portPath = const HalfTriangleLinePortPath(lineWidth: 2);
    //
    // Size portSize = const Size(10, 10);
    // ArrowPath arrow = ArrowPath(
    //   head: PortPath(Offset(0,0), portSize, portPath: portPath),
    //   tail: PortPath(Offset(100,0), portSize, portPath: portPath),
    // );
    // _arrowPaint..color = Colors.black;
    // canvas.drawPath(arrow.formPath(), _arrowPaint);

  }

  final Paint _helpPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = const Color(0xffE0DEEC);

  void drawHelp(Canvas canvas, Rect zone) {
    Path path = Path();
    final double width = zone.width;
    final double height = zone.height;
    Rect partZone = Rect.fromCenter(center: Offset.zero, width: width * 0.5, height: height * 0.5);

    path..moveTo(-width / 2, -height / 2)..relativeLineTo(width, height);
    path..moveTo(-width / 2, height / 2)..relativeLineTo(width, -height);
    path..moveTo(-width / 2, height / 2)..relativeLineTo(width, -height);
    path..moveTo(0, -height / 2)..relativeLineTo(0, height);
    path..moveTo(-width / 4, -height / 2)..relativeLineTo(0, height);
    path..moveTo(width / 4, -height / 2)..relativeLineTo(0, height);
    path..moveTo(-width / 2, 0)..relativeLineTo(width, 0);
    path..moveTo(-width / 2, height / 4)..relativeLineTo(width, 0);
    path..moveTo(-width / 2, -height / 4)..relativeLineTo(width, 0);

    path.addRect(zone);
    path.addOval(partZone);
    path.addOval(zone);
    canvas.drawPath(path, _helpPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
