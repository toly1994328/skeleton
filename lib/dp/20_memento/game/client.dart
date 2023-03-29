import 'package:skeleton/dp/20_memento/game/memento.dart';

void main() {
  Game game = Game(100);

  Memento memento = game.createMemento();

  for (int i = 0; i < 100; i++) {
    print("====第 $i 次投筛子====");
    print("====当前状态: $game====");
    game.bet();

    int curCoin = game.coin;
    print("====持有金币: ${game.coin}====");
    if (curCoin > memento.coin) {
      print("====金币增加，保存状态====");
    }else if(curCoin<memento.coin/2){
      print("====金币太少，恢复状态====");
      game.restoreMemento(memento);
    }
    print("");
  }
}
