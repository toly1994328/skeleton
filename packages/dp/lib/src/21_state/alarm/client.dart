import 'state.dart';

import 'context.dart';

class Client implements Context {
  String display = '';
  State _state = DayState();

  // 客户端期望的处理接口
  void clickUse(){
    _state.use(this);
  }
  void clickAlarm(){
    _state.alarm(this);
  }
  void clickPhone(){
    _state.alarm(this);
  }

  @override
  void changeState(State state) {
    print('状态切换: ${_state.runtimeType} --> ${state.runtimeType}');
    display = '';
    _state = state;
  }

  @override
  void record(String msg) {
    display += 'record:$msg \n';
  }

  @override
  void report(String msg) {
    display += 'report:$msg \n';
  }

  @override
  void setClock(int hour) {
    _state.setClock(this, hour);
  }
}

void main() {

    Client client = Client();
    client.setClock(12);

    client.clickUse();
    client.clickAlarm();
    print(client.display);


    client.setClock(23);
    client.clickUse();
    client.clickAlarm();
    print(client.display);

}
