// 记录游戏状态
import 'dart:math';

class Memento {
  int coin = 0;

  final List<String> _fruits = [];

  Memento._(this.coin);

  void addFruit(String fruit) {
    _fruits.add(fruit);
  }

  List<String> get fruits => List.of(_fruits);
}

List<String> _kFruits = ["苹果", "香蕉", "梨子", "菠萝"];

class Game {
  int _coin = 0;
  int get coin => _coin;
  List<String> _fruits = [];

  final Random _random = Random();

  Game(this._coin);

  void bet() {
    int count = _random.nextInt(6) + 1;
    if (count == 1) {
      _coin += 100;
      print("金币增加");
    } else if (count == 2) {
      _coin ~/= 2;
      print("金币减半");
    } else if (count == 6) {
      String fruit = randomFruit;
      _fruits.add(fruit);
      print("获得水果: $fruit");
    }
  }

  Memento createMemento(){
    Memento memento = Memento._(_coin);
    for (String fruit in _fruits) {
      memento.addFruit(fruit);
    }
    return memento;
  }

  void restoreMemento(Memento memento){
    _coin = memento.coin;
    _fruits = memento.fruits;
  }

  String get randomFruit {
    return _kFruits[_random.nextInt(_kFruits.length)];
  }

  @override
  String toString() {
    return 'Game{_coin: $_coin, _fruits: $_fruits}';
  }
}
