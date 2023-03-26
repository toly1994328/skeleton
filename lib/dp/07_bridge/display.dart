// 显示信息
class Display {
  final DisplayImpl impl;

  Display(this.impl);

  void open() {
    impl.rawOpen();
  }

  void close() {
    impl.rawClose();
  }

  void output() {
    impl.rawOutput();
  }

  void display() {
    open();
    output();
    close();
  }
}

abstract class DisplayImpl {
  void rawOpen();

  void rawClose();

  void rawOutput();
}

class RepeatDisplay extends Display {
  RepeatDisplay(super.impl);

  void repeatDisPlay(int times) {
    open();
    for (int i = 0; i < times; i++) {
      output();
    }
    close();
  }
}

class StringDisplayImpl extends DisplayImpl {
  final String value;

  StringDisplayImpl(this.value);

  @override
  void rawClose() {
    _printLine();
  }

  @override
  void rawOpen() {
    _printLine();
  }

  @override
  void rawOutput() {
    print('|$value|');
  }

  void _printLine() {
    String line = '+';
    for (int i = 0; i < value.length; i++) {
      line += "-";
    }
    line += '+';
    print(line);
  }
}

void main() {
  Display display1 = Display(StringDisplayImpl("hello toly"));
  Display display2 = RepeatDisplay(StringDisplayImpl("hello ls"));
  RepeatDisplay display3 = RepeatDisplay(StringDisplayImpl("hello wy"));
  display1.display();
  display2.display();
  display3.display();
  display3.repeatDisPlay(5);
}
