// 1.

Point p0 = Point(10, 4);
void main() {
  fun(p0);
  print(p0); // false
}

void fun(Point p){
  print(identical(p0, p));//true
  p = Point(3, 4);
  print(identical(p0, p));//false
  // Point p2 = p;
  // p2.x = 8;
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

  @override
  String toString() {
    return 'Point($x, $y)';
  }
}
