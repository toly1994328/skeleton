import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
class ScannerPainter extends CustomPainter{
  final Animation<double> animation;

  ScannerPainter({required this.animation}):super(repaint: animation);

  final Paint _bgPainter = Paint()..color = Colors.grey.withOpacity(0.1);
  final Paint _mainPainter = Paint()
    ..color = Colors.blue;


  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    canvas.drawRect(Offset.zero & size, _bgPainter);
    canvas.translate(0, animation.value*size.height*0.7);

    double count = 12;
    for(int i=0;i<count;i++){
      double shadowOpacity = 0.1*(1/count*i);
      double rectCenterX = size.width;
      double rectWidth = (size.width+(1/count*i)*size.width)/2;
      double rectHeight = 2;
      Rect rect =   Rect.fromCenter(center:Offset(rectCenterX/2,rectHeight+6.0*i),width: rectWidth,height: rectHeight);
      Path path = Path()..addRect(
          rect
      );
      drawShadows(canvas,path,[BoxShadow(color: Colors.blue.withOpacity(shadowOpacity),blurRadius: 4,offset: Offset(0,-4))]);
      Paint whitePaint = Paint();
      Color color;
      if(i==12){
        color = const Color(0xff7CC6EE);
      }else{
        color=  Color(0xff7CC6EE).withOpacity(0.5/count*i);
      }
      whitePaint.shader = ui.Gradient.linear(
          rect.centerLeft, rect.centerRight, [color.withOpacity(0),color,color.withOpacity(0),], [0,2/4,1]);
      canvas.drawPath(path, whitePaint);
    }
  }

  @override
  bool shouldRepaint(covariant ScannerPainter oldDelegate) {
    return animation.value!=oldDelegate.animation.value;
  }

  void drawShadows(Canvas canvas, Path path, List<BoxShadow> shadows) {
    for (final BoxShadow shadow in shadows) {
      final Paint shadowPainter = shadow.toPaint();
      if (shadow.spreadRadius == 0) {
        canvas.drawPath(path.shift(shadow.offset), shadowPainter);
      } else {
        Rect zone = path.getBounds();
        double xScale = (zone.width + shadow.spreadRadius) / zone.width;
        double yScale = (zone.height + shadow.spreadRadius) / zone.height;
        Matrix4 m4 = Matrix4.identity();
        m4.translate(zone.width / 2, zone.height / 2);
        m4.scale(xScale, yScale);
        m4.translate(-zone.width / 2, -zone.height / 2);
        canvas.drawPath(path.shift(shadow.offset).transform(m4.storage), shadowPainter);
      }
    }
    // Paint whitePaint = Paint()..color = Colors.white;
    // canvas.drawPath(path, whitePaint);
  }

}