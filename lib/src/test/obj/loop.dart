// 1. 1255
// 2168
// 2220

// 3857
// 3895

// 4519
Point p0 = Point(10, 4);
void main() {
  fun(p0);
  print(p0); // false
  int count = 1000000;
  int start = DateTime.now().microsecondsSinceEpoch;
  for(int i =0; i< count;i++){
    Point p0 = Point(i.toDouble(), i.toDouble());
    // p0.x = i.toDouble();
    // p0.y = i.toDouble();
  }
  int end = DateTime.now().microsecondsSinceEpoch;
  int cost = end - start;
  print('====cost:${cost} 微秒=======');
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
