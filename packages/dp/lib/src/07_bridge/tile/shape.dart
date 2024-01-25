abstract class Shape {
  void draw();
}

class Circle implements Shape {
  @override
  void draw() {
    print("绘制圆型");
  }
}


class Rect implements Shape {
  @override
  void draw() {
    print("绘制矩型");
  }
}