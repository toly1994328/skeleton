abstract class Prototype{
  Prototype clone();
}

class Message implements Prototype{
  String msg;


  Message(this.msg);

  @override
  Prototype clone() {
    return Message(msg);
  }

}