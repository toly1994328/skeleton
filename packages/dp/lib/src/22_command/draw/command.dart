import 'dart:collection';
import 'drawable.dart';

abstract class Command{
  void execute();
}


class MultiCommand implements Command{

  final Queue<Command> _commands = Queue();

  @override
  void execute() {
    Iterator<Command> it = _commands.iterator;
    while(it.moveNext()){
      it.current.execute();
    }
  }

  // 发送一条指令
  void send(Command cmd){
    if(cmd!=this){
      _commands.addLast(cmd);
    }
  }

  // 撤销最后一条指令
  void undo(){
    if(_commands.isNotEmpty){
      _commands.removeLast();
    }
  }

  // 撤销所有指令
  void clear(){
    _commands.clear();
  }
}

class DrawCommand extends Command{
  Drawable drawable;
  int x;
  int y;

  DrawCommand(this.drawable,this.x,this.y);

  @override
  void execute() {
    drawable.draw(x, y);
  }

}