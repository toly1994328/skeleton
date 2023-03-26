import 'mediator.dart';

// 仲裁者进行通报的组员接口
abstract class Colleague {
  void setMediator(Mediator mediator);

  void receive();
}

class ConcreteColleague1 implements Colleague {
  Mediator? mediator;

  @override
  void setMediator(Mediator mediator) {
    this.mediator = mediator;
  }

  @override
  void receive() {
    print("=========receive1==============");
  }
}

class ConcreteColleague2 implements Colleague {
  Mediator? mediator;

  @override
  void setMediator(Mediator mediator) {
    this.mediator = mediator;
  }

  @override
  void receive() {
    print("=========receive2==============");
  }
}
