import 'package:flutter/material.dart';

class PainterBox extends CustomPainter {

  final Paint _bgPainter = Paint()
    ..color = Colors.grey.withOpacity(0.2);
  final Paint _mainPainter = Paint()
    ..color = Colors.blue;
  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    // canvas.save();
    // canvas.restore();

    canvas.translate(0, size.height);
    _drawAxis(canvas,size);

    canvas.scale(1,-1);
    canvas.drawRect(Offset.zero & size, _bgPainter);
    canvas.drawCircle(Offset.zero, 10, _mainPainter);
    canvas.drawCircle(Offset(100, 100), 10, _mainPainter);
    canvas.drawCircle(Offset(150, 250), 10, _mainPainter);
    canvas.drawCircle(Offset(250, 250), 10, _mainPainter);
    canvas.drawCircle(Offset(50, 150), 10, _mainPainter);

  }

  @override
  bool shouldRepaint(covariant PainterBox oldDelegate) {
    return false;
  }

  TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center, textDirection: TextDirection.ltr);

  Paint axisPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  void _drawAxis(Canvas canvas, Size size){
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
    textPainter.paint(canvas, Offset(size.width - textSize.width, 5));
    textPainter.text = const TextSpan(
        text: 'y 轴', style: TextStyle(fontSize: 12, color: Colors.black));
    textPainter.layout(); // 进行布局
    Size textSize2 = textPainter.size; // 尺寸必须在布局后获取
    textPainter.paint(canvas,
        Offset(-textSize2.width + textSize2.width/2, -size.height - textSize2.height-3));
  }

}
