import 'package:flutter/material.dart';
import 'package:render2d/render2d.dart';

class ShapeShow extends StatelessWidget {

  final PathBuilder pathBuilder;

  const ShapeShow({super.key, required this.pathBuilder});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey,
        // border: Border.all(),

        // borderRadius: BorderRadius.circular(10)
      ),
      child: CustomPaint(
        size: Size(100,100),
        painter: ShapePainter(pathBuilder),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final PathBuilder pathBuilder;


  ShapePainter(this.pathBuilder);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 1;
    canvas.drawPath(pathBuilder.builder(), paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
