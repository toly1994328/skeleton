import 'package:flutter/material.dart';
import 'package:paint/structure/wrap_text.dart';

class DraftPaper extends StatelessWidget {
  const DraftPaper({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DraftPaperPainter(),
    );
  }
}

class DraftPaperPainter extends CustomPainter {
  TextPainter painter = TextPainter(textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate((size.width ~/ 2).toDouble(), (size.height ~/ 2).toDouble());
    // canvas.drawCircle(Offset.zero, 100, Paint());
    // WrapText(text: '0').render(canvas);
    Box(size: Size(40,40),text: "0").render(canvas);
    canvas.translate(46,0);
    Box(size: Size(40,40),text: "1").render(canvas);
    canvas.translate(46,0);

    Box(size: Size(40,40),text: "2").render(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


