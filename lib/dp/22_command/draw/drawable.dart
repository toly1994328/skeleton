import 'command.dart';

abstract class Drawable {
  void draw(int x, int y);
}

class Paper implements Drawable {
  final MultiCommand history;

  Paper(this.history);

  void paint() {
    history.execute();
  }

  @override
  void draw(int x, int y) {
    print("===在($x,$y)处绘制圆=====");
  }
}

void main() {
  MultiCommand commands = MultiCommand();
  Paper paper = Paper(commands);


  commands.send(DrawCommand(paper, 18, 18));
  commands.send(DrawCommand(paper, 20, 20));
  commands.send(DrawCommand(paper, 30, 30));

  commands.execute();
}
