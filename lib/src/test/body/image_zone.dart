import 'dart:ui';

import 'line.dart';

class ImageZone {
  final Image image;
  final Rect rect;

  Line? _line;

  final Paint imagePaint = Paint()..filterQuality = FilterQuality.high;

  ImageZone({required this.image, this.rect = Rect.zero});

  Line get line {
    if (_line != null) {
      return _line!;
    }
    Offset start = Offset(
        -(image.width / 2 - rect.right), -(image.height / 2 - rect.bottom));
    Offset end = start.translate(-rect.width, -rect.height);
    _line = Line(start: start, end: end);
    return _line!;
  }

  void paint(Canvas canvas, Line line) {
    canvas.save();
    canvas.translate(line.start.dx, line.start.dy);
    canvas.rotate(line.positiveRad - this.line.positiveRad);
    canvas.translate(-line.start.dx, -line.start.dy);
    canvas.drawImageRect(
      image,
      rect,
      rect.translate(-image.width / 2, -image.height / 2),
      imagePaint,
    );
    canvas.restore();
  }
}
