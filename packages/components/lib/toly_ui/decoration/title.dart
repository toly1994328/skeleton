import 'package:flutter/material.dart';

class TolyTitle extends StatelessWidget {
  final Widget child;
  final Color? lineColor;
  final Color? color;
  const TolyTitle({
    super.key,
    required this.child,
    this.lineColor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: TitleDecoration(
        color,lineColor,
      ),
      child: child,
    );
  }
}

class TitleDecoration extends Decoration {
  final Color? lineColor;
  final Color? color;

  const TitleDecoration( this.color,this.lineColor,);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      TitlePainter(color: color, lineColor: lineColor);
}

class TitlePainter extends BoxPainter {
  final Color? color;
  final Color? lineColor;

  const TitlePainter({this.color, this.lineColor});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    Size size = configuration.size ?? Size.zero;
    final Paint paint = Paint()
      // ..style = PaintingStyle.stroke
      ..color = color??Colors.transparent
      ..strokeWidth = 1;


    final Rect zone = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height,
    );

    canvas.drawRect(zone, paint);
    final Paint paint2 = Paint()
      ..strokeWidth = 1
      // ..style = PaintingStyle.stroke
      //   ..color = const Color(0xffFFFAA7);
      ..color = lineColor??Colors.transparent;

    const double start = 4;
    canvas.drawLine(const Offset(0, start), Offset(size.width, start), paint2);
    double end = size.height - 4;
    canvas.drawLine(Offset(0, end), Offset(size.width, end), paint2);

    canvas.drawCircle(Offset(10,size.height/2), 4, paint2);

    //
    // canvas.translate(
    //   offset.dx + (configuration.size?.width??0) / 2,
    //   offset.dy + (configuration.size?.height??0) / 2,
    // );
    //
    // final Rect zone = Rect.fromCenter(
    //   center: Offset.zero,
    //   width: configuration.size.width,
    //   height: configuration.size.height,
    // );
    //
    // path.addRRect(RRect.fromRectAndRadius(
    //   zone,
    //   Radius.circular(20),
    // ));
    //
    // const DashPainter(span: 4, step: 9).paint(canvas, path, paint);
    canvas.restore();
  }
}
