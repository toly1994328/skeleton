import 'dart:math';
import 'hand.dart';

abstract class Strategy{
  HandEvent next();
  void study(bool win);
}

// 赢了之后，继续保持之前的手势
class StayStrategy implements Strategy{
  final Random _random = Random();
  bool _won = false;
  HandEvent? _prev;

  @override
  HandEvent next() {
    if(!_won || _prev==null){
      _prev == HandEvent(HandType.values[_random.nextInt(3)]) ;
    }
    return _prev!;
  }

  @override
  void study(bool win) {
    _won = win;
  }
}

class RandomStrategy implements Strategy{
  final Random _random = Random();

  @override
  HandEvent next() {
    return HandEvent(HandType.values[_random.nextInt(3)]);
  }

  @override
  void study(bool win) {

  }

}