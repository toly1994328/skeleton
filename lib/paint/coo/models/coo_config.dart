class AxisRange {
  final double maxX;
  final double minX;
  final double maxY;
  final double minY;

  const AxisRange({
    this.maxX = 1.0,
    this.minX = -1.0,
    this.maxY = 1.0,
    this.minY = -1.0,
  });

  double get xSpan => maxX - minX;
  double get ySpan => maxY - minY;

  @override
  String toString() {
    return 'CooConfig{maxX: $maxX, minX: $minX, maxY: $maxY, minY: $minY}';
  }
}
