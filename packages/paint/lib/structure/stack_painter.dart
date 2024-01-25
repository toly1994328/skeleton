import 'package:flutter/material.dart';
import 'package:paint/structure/drawable/drawable.dart';

import '../components/arrow/arrow_path.dart';
import '../components/arrow/old.dart';
import '../components/arrow/port_path.dart';
import '../components/coordinate.dart';
import 'array_painter.dart';

class StackPainter extends CustomPainter {
  final bool activeGrid;
  final ArrayNode arrayNode;

  StackPainter({required this.arrayNode, this.activeGrid = true});

  static const double step = 20; // 方格变长
  final Coordinate coordinate = Coordinate(step: step);
  TextPainter _textPainter = TextPainter(
      textDirection: TextDirection.ltr, textAlign: TextAlign.center);

  final Paint _fillPainter = Paint()..color = Colors.blue;

  @override
  void paint(Canvas canvas, Size size) {
    if (activeGrid) {
      coordinate.paint(canvas, size);
    }
    canvas.translate(size.width / 2, size.height / 2);
    double stackHeight = 260;
    double stackWidth = 90;
    final double boxHeight = 36;

    StackDrawable stackDrawable = StackDrawable(Size(stackWidth,stackHeight),'stack');
      // ..addRect(Rect.fromLTWH(0, 0,  stackWidth,-boxHeight))
      // ..addRect(Rect.fromLTWH(0, -boxHeight,  stackWidth,-boxHeight))
    ;
    for (int i = 0; i < arrayNode.array.length; i++) {
      Rect rect = Rect.fromLTWH(0, -i*boxHeight,  stackWidth,-boxHeight);
      stackDrawable.add(BoxDrawable(rect,arrayNode.array[i].toString()));
    }
    // canvas.drawPath(nodes, fillPaint);

    stackDrawable.draw(canvas);


    // Path path = Path();
    // path..moveTo(0, -stackHeight)
    //   ..relativeLineTo(0, stackHeight)
    //   ..relativeLineTo(stackWidth, 0)
    //   ..relativeLineTo(0, -stackHeight)..addPath(nodes, Offset.zero);
    // canvas.drawPath(path, painter);
    // canvas.drawPath(nodes, painter);

    //
    // Paint painter = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..color = Colors.red
    //   ..strokeWidth = 1;
    // Rect rect = Rect.fromPoints(Offset.zero, const Offset(40, 40));
    // Path path = Path();
    // for (int i = 0; i < arrayNode.array.length; i++) {
    //   Rect curBox = rect.translate(40.0 * i, 0);
    //   path.addRect(curBox);
    //   Color textColor = Colors.black;
    //   if(i==arrayNode.activeIndex){
    //     textColor = Colors.white;
    //     canvas.drawRect(curBox, _fillPainter);
    //
    //     Offset p0 = Offset(40.0 * i-20, 0-4);
    //     Offset p1 = Offset(40.0 * i-20, -26);
    //     ArrowPath arrow2 = ArrowPath(
    //       p0.translate(40, 0),
    //       p1.translate(40, 0),
    //       head: PortPath(
    //         const Size(10, 10),
    //         portPath: const ThreeAnglePortPath(rate: 0.8),
    //       ),
    //       // tail: PortPath(
    //       //   const Size(8, 8),
    //       //   portPath: const CirclePortPath(),
    //       // ),
    //     );
    //     canvas.drawPath(arrow2.formPath(), _fillPainter);
    //     _textPainter.text = TextSpan(
    //         text: arrayNode.activeIndexName,
    //         style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold));
    //     _textPainter.layout();
    //     _textPainter.paint(canvas, Offset(40.0 * i+20-_textPainter.size.width/2, -48));
    //   }
    //
    //   _textPainter.text = TextSpan(
    //       text: arrayNode.array[i].toString(),
    //       style: TextStyle(color: textColor,fontWeight: FontWeight.bold));
    //   _textPainter.layout();
    //   Size textSize = _textPainter.size;
    //   double offsetX = (40-textSize.width)/2;
    //   double offsetY = (40-textSize.height)/2;
    //   _textPainter.paint(canvas, Offset(40.0 * i+offsetX, 0+offsetY));
    // }
    // canvas.drawPath(path, painter);
    // canvas.drawRect(rect, painter);
    // canvas.drawRect(rect.translate(40, 0), painter);
    // canvas.drawRect(rect.translate(40*2, 0), painter);
    // canvas.drawRect(rect.translate(40*3, 0), painter);

    // canvas.drawCircle(Offset.zero, 10, Paint());
  }

  @override
  bool shouldRepaint(covariant StackPainter oldDelegate) {
    return activeGrid != oldDelegate.activeGrid ||
        arrayNode != oldDelegate.arrayNode;
  }
}
