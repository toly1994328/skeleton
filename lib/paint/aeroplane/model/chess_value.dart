import 'package:flutter/cupertino.dart';

class ChessValue extends ChangeNotifier {
  List<StepPoint> data = [];

  void repaint() {
    notifyListeners();
  }

  void initData(double bixSize) {
    data.clear();
    // Offset a1 = Offset(bixSize * 16, bixSize * 8 + bixSize / 2);
    // data.add(StepPoint(position: a1, index: 1, playerType: PlayerType.one));

    Offset a2 = Offset(bixSize * 16, bixSize * 8 + bixSize / 2+bixSize);
    data.add(StepPoint(position: a2, index: 1, playerType: PlayerType.two));

    Offset a3 = a2.translate(0, bixSize);
    data.add(StepPoint(position: a3, index: 2, playerType: PlayerType.three));

    Offset a4 = a3.translate(-bixSize*2*0.2,bixSize+bixSize/2-bixSize*2*0.2);
    data.add(StepPoint(position: a4, index: 3, playerType: PlayerType.four));

    Offset a5 = a3.translate(-bixSize*2+bixSize/2,bixSize+bixSize/2);
    data.add(StepPoint(position: a5, index: 4, playerType: PlayerType.one));

    Offset a6 = a5.translate(-bixSize,0);
    data.add(StepPoint(position: a6, index: 5, playerType: PlayerType.two));

    Offset a7 = a4.translate(-bixSize*3-bixSize*0.2,0);
    data.add(StepPoint(position: a7, index: 6, playerType: PlayerType.three));


    Offset a8 = a7.translate(-(bixSize-bixSize*0.2),(bixSize-bixSize*0.2));
    data.add(StepPoint(position: a8, index: 7, playerType: PlayerType.four));

    Offset a9 = a6.translate(-bixSize*1.5,bixSize*1.5);
    data.add(StepPoint(position: a9, index: 8, playerType: PlayerType.one));


    Offset a10 = a9.translate(0,bixSize);
    data.add(StepPoint(position: a10, index: 9, playerType: PlayerType.two));

    Offset a11 = a8.translate(0,(bixSize-bixSize*2*0.2)*2+bixSize*2);
    data.add(StepPoint(position: a11, index: 10, playerType: PlayerType.three));

    Offset a12 = a10.translate(-bixSize*1.5,bixSize*1.5);
    data.add(StepPoint(position: a12, index: 11, playerType: PlayerType.four));

    Offset a13 = a12.translate(-bixSize,0);
    data.add(StepPoint(position: a13, index: 12, playerType: PlayerType.one));

    double y = 17*bixSize/2 ;

    // 一个坐标 （a,b） 关于 y = c 对称，对称点为(px,py)
    // 则满足关系： (a+px)/2 = c ===> px = 2*c - a


    List<StepPoint> mirror = [];
    for(int i=0;i<data.length;i++){
      Offset position = data[i].position;
      PlayerType type = PlayerType.values[(data.length-(i+3))%PlayerType.values.length];
      Offset p = Offset((2*y-position.dx), position.dy);
      mirror.add(StepPoint(position: p, index: 25-data[i].index+1, playerType: type));
    }
    data.addAll(mirror);

    double x = 17*bixSize/2 ;

    // 一个坐标 （a,b） 关于 y = c 对称，对称点为(px,py)
    // 则满足关系： (a+px)/2 = c ===> px = 2*c - a

    List<StepPoint> mirrorX = [];
    for(int i=0;i<data.length;i++){
      Offset position = data[i].position;
      Offset p = Offset(position.dx, (2*y-position.dy));
      int index = 0;
      PlayerType type;
      if(p.dx>x){
         type = PlayerType.values[(data.length-(i+1))%PlayerType.values.length];
         index =(48-(i-3));
      }else{
         type = PlayerType.values[(i+3)%PlayerType.values.length];
         index =i+12+3;
      }
      mirrorX.add(StepPoint(position: p, index: index, playerType: type));
    }
    data.addAll(mirrorX);

  }


}

enum PlayerType {
  one, // 蓝
  two, // 黄
  three, // 绿
  four, // 红
}

class StepPoint {
  final Offset position;
  final int index;
  final PlayerType playerType;

  StepPoint({
    required this.position,
    required this.index,
    required this.playerType,
  });
}
