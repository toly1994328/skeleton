import 'system/parser_system.dart';
import 'system/render_system.dart';
import 'system/screen_system.dart';

class ShapeDrawer {

  final String shape;


  ShapeDrawer(this.shape);

  ParserSystem parserSystem = ParserSystem();
  RenderSystem renderSystem = RenderSystem();
  ScreenSystem screenSystem = ScreenSystem();

void draw(){
    parserSystem.loadData();
    parserSystem.readData();
    parserSystem.parser();
    renderSystem.shaderVertex();
    renderSystem.transformVertex();
    renderSystem.component();
    renderSystem.rasterization();
    renderSystem.colorful();
    screenSystem.getData();
    screenSystem.parserData();
    screenSystem.transform();
    screenSystem.toByte();
    screenSystem.show(shape);
    parserSystem.close();
    parserSystem.release();
  }

}

main(){
   ShapeDrawer("矩形").draw();
}