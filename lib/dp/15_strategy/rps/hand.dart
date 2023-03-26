// 手势枚举
enum HandType {
  rock, // 石头
  scissors, // 剪刀
  paper // 布
}

enum GameStatus { win, tie, loss }

class HandEvent {
  final HandType type;

  HandEvent(this.type);

  GameStatus fight(HandEvent other) {
    if (other.type == type) {
      // 平局
      return GameStatus.tie;
    }

    // 胜局
    bool win = type == HandType.rock && other.type == HandType.scissors ||
        type == HandType.scissors && other.type == HandType.paper ||
        type == HandType.paper && other.type == HandType.rock;

    return win ? GameStatus.win : GameStatus.loss;
  }
}

void main(){
  HandEvent e1 = HandEvent(HandType.rock);
  HandEvent e2 = HandEvent(HandType.paper);
  HandEvent e3 = HandEvent(HandType.scissors);
  print(e2.fight(e3));
  print(e2.fight(e2));
}