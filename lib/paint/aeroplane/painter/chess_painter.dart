import 'package:flutter/material.dart';
import 'package:skeleton/paint/aeroplane/painter/board_painter.dart';

import '../model/chess_value.dart';

class ChessPainter extends CustomPainter{
  final ChessValue data;


  ChessPainter(this.data):super(repaint: data);

  final Paint _bgPaint = Paint();
  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  @override
  void paint(Canvas canvas, Size size) {
    Rect zone = Offset.zero & size;
    Rect painterZone = zone.deflate(size.width * 0.04);
    canvas.translate((size.width/2-painterZone.width/2), (size.height/2-painterZone.height/2));
    canvas.drawCircle(Offset.zero, 5, _bgPaint..color = Colors.blue);
    double bixSize = painterZone.width / 17;
    data.initData(bixSize);

    for (StepPoint point in data.data) {
      canvas.drawCircle(point.position, 12, _bgPaint..color = Colors.black);
      canvas.drawCircle(point.position, 9, _bgPaint..color = BoardPainter.blockColors[point.playerType.index]);
      textPainter.text = TextSpan(
        text: '${point.index}',
        style: TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.bold),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        point.position.translate(-textPainter.size.width/2, -textPainter.size.height/2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}