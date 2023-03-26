import 'colleague.dart';

abstract class Mediator {
  void createColleagues();

  void colleagueChanged();
}


class ConcreteMediator implements Mediator {
  late ConcreteColleague1 cc1;
  late ConcreteColleague2 cc2;

  @override
  void colleagueChanged() {
    // 在此处书写逻辑，通知被调停的对象处理信息
    cc1.receive();
    cc2.receive();
  }

  @override
  void createColleagues() {
    cc1 = ConcreteColleague1();
    cc2 = ConcreteColleague2();
    cc1.setMediator(this);
    cc2.setMediator(this);
  }
}

void main(){
  ConcreteMediator cm = ConcreteMediator();
  cm.createColleagues();
  cm.colleagueChanged();
}