import 'display.dart';

abstract class Border extends Display {
  // 装饰对象持有被装饰物
  final Display display;

  Border(this.display);
}

class SideBorder extends Border {
  final String sideChar;

  SideBorder(this.sideChar, super.display);

  @override
  int get columns => 1 + display.columns + 1;

  @override
  String line(int row) {
    return sideChar + display.line(row) + sideChar;
  }

  @override
  int get rows => display.rows;
}

class FullBorder extends Border {
  FullBorder(super.display);

  @override
  int get columns => 1 + display.columns + 1;

  @override
  int get rows => 1 + display.rows + 1;

  String _printLine(String char, int count) {
    String line = '';
    for (int i = 0; i < count; i++) {
      line += char;
    }
    return line;
  }

  @override
  String line(int index) {
    String top = '+${_printLine('-', display.columns)}+';
    if (index == 0 || index == display.rows + 1) {
      return top;
    }

    return '|${display.line(index - 1)}|';
  }
}
