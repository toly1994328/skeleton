import 'package:flutter/material.dart';

import '../components/arrow/arrow_path.dart';
import '../components/arrow/old.dart';
import '../components/arrow/port_path.dart';
import '../components/coordinate.dart';
import 'port_path_painter.dart';

class ArrowPage extends StatelessWidget {
  const ArrowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: CustomPaint(
        painter: ArrowPainter(),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter{
  final Paint _fillPainter = Paint()..color=Colors.red..style=PaintingStyle.fill;

  static const double step = 20; // 方格变长
  final Coordinate coordinate = Coordinate(step: step);
  TextPainter _textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
  );


  @override
  void paint(Canvas canvas, Size size) {

    // coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    Offset p0 = Offset(0, 0);
    Offset p1 = Offset(80, 80);

    // PortPath port1 =  PortPath(
    //   p0,
    //   Size(20.0,20.0),
    //   portPath: const ThreeAnglePortPath(rate: 0.8),
    // );
    // canvas.drawPath(port1.formPath(), _fillPainter);
    //
    // PortPath port2 =  PortPath(
    //   p1,
    //   Size(20.0,20.0),
    //   portPath: const ThreeAnglePortPath(rate: 0.8),
    // );
    // canvas.drawPath(port2.formPath(), _fillPainter);

    // canvas.save();
    // for(int i=0;i<4;i++){
    //   PortPath port1 =  PortPath(
    //     p0,
    //     Size(20.0*(i+1),20.0*(i+1)),
    //     portPath: const ThreeAnglePortPath(rate: 0.8),
    //   );
    //   canvas.drawPath(port1.formPath(), _fillPainter);
    //   canvas.translate(80, 0);
    // }
    // canvas.restore();
    //
    // canvas.save();
    // canvas.translate(0, 100);
    // for(int i=0;i<4;i++){
    //   PortPath port1 =  PortPath(
    //     p0,
    //     Size(40.0,40.0),
    //     portPath:  ThreeAnglePortPath(rate: (i+1)*0.3),
    //   );
    //   canvas.drawPath(port1.formPath(), _fillPainter);
    //   canvas.translate(80, 0);
    // }
    // canvas.restore();

    ArrowPath arrow2 = ArrowPath(
      p0,p1,
      head: PortPath(
        const Size(10, 10),
        portPath: const ThreeAnglePortPath(rate: 0.8),
      ),
      tail: PortPath(
        const Size(10, 10),
        portPath: const ThreeAnglePortPath(rate: 0.8),
      ),
    );
    canvas.drawPath(arrow2.formPath(), _fillPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
      return true;
  }

}