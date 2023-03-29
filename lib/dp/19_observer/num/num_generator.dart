import 'dart:math';

abstract class NumGenerator {
  List<Observer> _listeners = [];

  int get num;

  void generate();

  void addListener(Observer listener) {
    _listeners.add(listener);
  }

  void removeListener(Observer listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    for (Observer listener in _listeners) {
      listener.update(this);
    }
  }
}

abstract class Observer {
  void update(NumGenerator generator);
}

class RandomNumGenerator extends NumGenerator {
  final Random _random = Random();
  int _num = 0;

  @override
  void generate() {
    _num = _random.nextInt(100);
    notifyListeners();
  }

  @override
  int get num => _num;
}

class DigitObserver implements Observer {
  @override
  void update(NumGenerator generator) {
    print("${runtimeType}: ${generator.num}");
  }
}

class GraphObserver implements Observer {
  @override
  void update(NumGenerator generator) {
    String output = '';
    for (int i = 0; i < generator.num; i++) {
      output += '*';
    }
    print("${runtimeType}: ${output}");
  }
}

void main(){
  NumGenerator generator = RandomNumGenerator();
  Observer ob1 = DigitObserver();
  Observer ob2=GraphObserver();
  generator.addListener(ob1);
  generator.addListener(ob2);

  generator.generate();
  generator.generate();
}