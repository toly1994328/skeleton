import 'context.dart';

abstract class State{
  void setClock(Context context,int hour);
  void use(Context context);
  void alarm(Context context);
  void call(Context context);
}

class DayState implements State{

  @override
  void alarm(Context context) {
    context.report("按下警铃(白天)");
  }

  @override
  void call(Context context) {
    context.report("正常通话(白天)");
  }

  @override
  void setClock(Context context,int hour) {
   if(hour<9||17<=hour){
     context.changeState(NightState());
   }
  }

  @override
  void use(Context context) {
    context.record("白天使用金库");
  }

}

class NightState implements State{

  @override
  void alarm(Context context) {
    context.report("按下警铃(晚上)");
  }

  @override
  void call(Context context) {
    context.record("录音留言(夜晚)");
  }

  @override
  void setClock(Context context,int hour) {
    if(hour<9||17<=hour){
      context.changeState(DayState());
    }
  }

  @override
  void use(Context context) {
    context.report("注意: 有人晚上使用金库");
  }

}