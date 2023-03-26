import 'shape.dart';

// 产品
class Tile{
  final Shape shape;

  Tile(this.shape);

  void show(){
    shape.draw();
  }
}

 class GlassTile extends Tile {

  GlassTile(super.shape);

  @override
  void show() {
    super.show();
    print("玻璃");
  }
}

class WoodTile extends Tile {

  WoodTile(super.shape);

  @override
  void show() {
    super.show();
    print("木头");
  }
}