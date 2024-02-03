import 'dart:ui';
import 'dart:math' as math;

class Vector {
  final double x;
  final double y;

  const Vector(this.x, this.y);

  /// 向量长度
  double get distance => math.sqrt(x * x + y * y);

  /// 向量缩放
  Vector scale(double scale) => Vector(x * scale, y * scale);

}
