// 1.

void main() {
  Point p0 = Point(10, 4);
  Point p1 = Point(10, 4);
  print(p0 == p1); // false
  print(identical(p0, p1)); // false
}

class Point {
  double x = 0;
  double y = 0;

  Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
