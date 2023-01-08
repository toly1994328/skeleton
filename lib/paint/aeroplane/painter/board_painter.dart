import 'dart:math';

import 'package:flutter/material.dart';

class BoardPainter extends CustomPainter {
  final Color backgroundColor = const Color(0xff6ca8e6);
  final Paint _bgPaint = Paint();
  final Paint _holePaint = Paint()..color = Colors.white;
  final Paint _blockPaint = Paint();

  final List<Color> blockColors = const [
    Color(0xff00bdfc), Color(0xffFFCC1C),
    Color(0xff4faa29), Color(0xfffe1a10),
  ];

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  @override
  void paint(Canvas canvas, Size size) {

    Rect zone = Offset.zero & size;

    Rect painterZone = zone.deflate(size.width * 0.04);
    canvas.drawColor(backgroundColor, BlendMode.src);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        zone.deflate(size.width * 0.02),
        Radius.circular(size.width * 0.02),
      ),
      _bgPaint..color = Colors.white,
    );

    // _drawHelper(canvas,size,painterZone);


    canvas.translate(
      size.width / 2,
      size.height / 2,
    );
    // canvas.drawCircle(Offset.zero, 5, _bgPaint..color = Colors.blue);

    double boxHeight = painterZone.width / 17;
    double boxWidth = boxHeight * 2;
    print("========${painterZone.width}=====${painterZone.height}==============");

    for(int i=0;i<4;i++){
      canvas.save();
      canvas.rotate(pi / 2 * i);

      // 绘制箭头格
      canvas.save();
      canvas.translate(painterZone.width / 2, 0);
      drawArrow(canvas, boxWidth, boxHeight, i);
      canvas.restore();

      // 绘制四分之一格
      canvas.save();
      canvas.translate(painterZone.width / 2, 0);
      drawBlocks(canvas,boxWidth,boxHeight,(i+1)%blockColors.length);
      canvas.restore();

      // 绘制机场
      canvas.save();
      double boxSide = boxHeight*4;
      canvas.translate(painterZone.width / 2 -boxSide/2 , painterZone.height / 2-boxSide/2*0.8);
      drawAirport(canvas,boxHeight*4,blockColors[i]);
      canvas.restore();

      canvas.restore();
    }

  }

  void drawAirport(Canvas canvas, double side,Color color){
    canvas.drawRect(Rect.fromCenter(center: Offset(
      side*0.35,
      -side*0.43,
    ), width: side/3, height: side/3), _blockPaint..color = color);

    canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: side*0.8, height: side*0.8), _blockPaint..color = color );
    double radius = side/2 * 0.25;
    double offset = radius*1.4;
    canvas.drawCircle(Offset(-offset, -offset), side/2 * 0.25, _holePaint);
    canvas.drawCircle(Offset(offset, offset), side/2 * 0.25, _holePaint);
    canvas.drawCircle(Offset(-offset, offset), side/2 * 0.25, _holePaint);
    canvas.drawCircle(Offset(offset, -offset), side/2 * 0.25, _holePaint);

    canvas.drawCircle(Offset(
      side*0.35,
      -side*0.43,
    ), side/2 * 0.25, _holePaint);

    textPainter.text = TextSpan(
      text: 'Start',
      style: TextStyle(fontSize: side/13, color: color,fontWeight: FontWeight.bold),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        side*0.35 - textPainter.width/2,
        -side*0.43- textPainter.height/2,
      ),
    );

  }

  void drawBlocks(Canvas canvas, double width, double height,int firstIndex){
    int count = firstIndex;
    canvas.translate(-width/2, height);
    Rect rect = Rect.fromCenter(center: Offset.zero, width: width, height: height);
    canvas.drawRect(rect, _blockPaint..color = blockColors[count]);
    canvas.drawCircle(Offset.zero, height / 2 * 0.75, _holePaint);

    count = (count+1)%blockColors.length;
    canvas.translate(0, height);
    canvas.drawRect(rect, _blockPaint..color = blockColors[count]);
    canvas.drawCircle(Offset.zero, height / 2 * 0.75, _holePaint);

    count = (count+1)%blockColors.length;
    canvas.translate(0, height/2+width/2);
    Path triPath = Path()..relativeLineTo(-width/2, width/2)..relativeLineTo(0, -width)..relativeLineTo(width, 0)..close();
    canvas.drawPath(triPath, _blockPaint..color = blockColors[count]);
    canvas.drawCircle(Offset(-width*0.2,-width*0.2), height / 2 * 0.75, _holePaint);

    count = (count+1)%blockColors.length;
    canvas.translate(-height/2-width/2, 0);
    Rect rect2 = Rect.fromCenter(center: Offset.zero, width: height, height: width);
    canvas.drawRect(rect2, _blockPaint..color = blockColors[count]);
    canvas.drawCircle(Offset.zero, height / 2 * 0.75, _holePaint);

    count = (count+1)%blockColors.length;
    canvas.translate(-height, 0);
    canvas.drawRect(rect2, _blockPaint..color = blockColors[count]);
    canvas.drawCircle(Offset.zero, height / 2 * 0.75, _holePaint);

    count = (count+1)%blockColors.length;
    canvas.translate(-height/2-width/2, 0);
    canvas.save();
    canvas.rotate(pi/2);
    canvas.drawPath(triPath, _blockPaint..color = blockColors[count]);
    canvas.drawCircle(Offset(-width*0.2,-width*0.2), height / 2 * 0.75, _holePaint);
    canvas.restore();

    count = (count+1)%blockColors.length;
    canvas.save();
    canvas.rotate(-pi/2);
    canvas.drawPath(triPath, _blockPaint..color = blockColors[count]);
    canvas.drawCircle(Offset(-width*0.2,-width*0.2), height / 2 * 0.75, _holePaint);
    canvas.restore();

    count = (count+1)%blockColors.length;
    canvas.translate(0, height/2+width/2);
    canvas.drawRect(rect, _blockPaint..color = blockColors[count]);
    canvas.drawCircle(Offset.zero, height / 2 * 0.75, _holePaint);

    count = (count+1)%blockColors.length;
    canvas.translate(0, height);
    canvas.drawRect(rect, _blockPaint..color = blockColors[count]);
    canvas.drawCircle(Offset.zero, height / 2 * 0.75, _holePaint);

    count = (count+1)%blockColors.length;
    canvas.translate(0, height/2+width/2);
    canvas.drawPath(triPath, _blockPaint..color = blockColors[count]);
    canvas.drawCircle(Offset(-width*0.2,-width*0.2), height / 2 * 0.75, _holePaint);

    count = (count+1)%blockColors.length;
    canvas.translate(-height/2-width/2,0);
    canvas.drawRect(rect2, _blockPaint..color = blockColors[count]);
    canvas.drawCircle(Offset.zero, height / 2 * 0.75, _holePaint);

    count = (count+1)%blockColors.length;
    canvas.translate(-height,0);
    canvas.drawRect(rect2, _blockPaint..color = blockColors[count]);
    canvas.drawCircle(Offset.zero, height / 2 * 0.75, _holePaint);
  }

  final Paint _linePaint = Paint()..style=PaintingStyle.stroke..strokeWidth=2;

  void drawArrow(Canvas canvas, double width, double height,int index) {
    Color color = blockColors[index];
    // canvas.drawCircle(Offset.zero, 5, _bgPaint..color = Colors.blue);
    Path linePath = Path()
      ..moveTo(-width*2-height/2, -width)
      ..relativeLineTo(0, width*2)
      ..relativeLineTo(height*0.15, -height*0.3);

    canvas.drawPath(linePath, _linePaint..color = blockColors[(index+2)%blockColors.length]);
    Path path = Path()
      ..relativeLineTo(0, -height / 2)
      ..relativeLineTo(-7 * height, 0)
      ..relativeLineTo(0, -height * 0.9)
      ..relativeLineTo(-width / 2 * 1.4, height * 0.9 + height / 2)
      ..relativeLineTo(width / 2 * 1.4, height * 0.9 + height / 2)
      ..relativeLineTo(0, -height * 0.9)
      ..relativeLineTo(7 * height, 0)
      ..close();
    canvas.drawPath(path, _blockPaint..color = color);

    canvas.save();
    drawHole(canvas, width, height);
    canvas.translate(-width, 0);
    for (int i = 0; i < 6; i++) {
      drawHole(canvas, width / 2, height);
      canvas.translate(-width / 2, 0);
    }
    canvas.restore();
  }

  void _drawHelper(Canvas canvas, Size size,Rect painterZone){
    canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        Paint()..style = PaintingStyle.stroke);
    canvas.drawLine(
        Offset(size.width / 2, 0),
        Offset(size.width/2, size.height),
        Paint()..style = PaintingStyle.stroke);

    canvas.drawRect(
      painterZone,
      _bgPaint..color = Colors.grey.withOpacity(0.1),
    );
  }

  void drawHole(Canvas canvas, double width, double height) {
    canvas.drawCircle(Offset(-width / 2, 0), height / 2 * 0.75, _holePaint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
