import 'hand.dart';
import 'strategy.dart';

class Player{
  final String name;
  final Strategy strategy;
  int _winCount = 0;
  int _lossCount = 0;
  int _tieCount = 0;

  Player(this.name, this.strategy);

  HandEvent next(){
    return strategy.next();
  }

  void win(){
    strategy.study(true);
    _winCount++;
  }

  void loss(){
    strategy.study(false);
    _lossCount++;
  }
  void tie(){
    _tieCount++;
  }

  @override
  String toString() {
    return 'Player{name: $name, strategy: $strategy, _winCount: $_winCount, _lossCount: $_lossCount, _tieCount: $_tieCount}';
  }
}