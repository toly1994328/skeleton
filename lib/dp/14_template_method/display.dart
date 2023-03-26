abstract class AbstractDisplay {
  void open();

  void show();

  void close();

  void display() {
    open();
    for (int i = 0; i < 5; i++) {
      show();
    }
    close();
  }
}

class NumDisplay extends AbstractDisplay {
  final num value;

  NumDisplay(this.value);

  @override
  void open() {
    print("<<");
  }

  @override
  void close() {
    print(">>");
  }

  @override
  void show() {
    print(value);
  }
}

class StringDisplay extends AbstractDisplay{
  final String value;

  StringDisplay(this.value);
  @override
  void close() {
    _printLine();
  }

  @override
  void open() {
    _printLine();
  }

  @override
  void show() {
    print('|$value|');
  }

  void _printLine(){
    String line = '+';
    for(int i=0;i<value.length;i++){
      line += "-";
    }
    line += '+';
    print(line);
  }
}

void main(){
  AbstractDisplay display = NumDisplay(30);
  display.display();

  AbstractDisplay display2 = StringDisplay('toly1994');
  display2.display();
}