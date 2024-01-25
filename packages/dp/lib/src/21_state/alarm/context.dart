import 'state.dart';

abstract class Context {
  void setClock(int hour);

  void changeState(State state);

  void report(String msg);

  void record(String msg);
}
