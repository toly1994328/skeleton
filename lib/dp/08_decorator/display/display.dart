abstract class Display{
  int get columns;
  int get rows;
  String line(int index);

  void show(){
    for(int i=0;i<rows;i++){
      print(line(i));
    }
  }
}

class StringDisplay extends Display{
  final String msg;

  StringDisplay(this.msg);

  @override
  int get columns => msg.length;

  @override
  String line(int index) {
    if(index ==0) return msg;
    return '';
  }

  @override
  int get rows => 1;

}
