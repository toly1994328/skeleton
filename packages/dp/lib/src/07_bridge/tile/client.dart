import 'shape.dart';
import 'tile.dart';

void main(){
  Tile tile = GlassTile(Circle());
  tile.show();

  Tile tile2 = WoodTile(Rect());
  tile2.show();
}