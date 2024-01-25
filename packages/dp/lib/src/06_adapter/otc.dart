class USB extends Plug{

  final String data;

  USB(this.data);

  @override
  String transfer(){
    return "来自于USB: $data";
  }
}

abstract class TypeC{
  String transfer();
}

abstract class Plug{
  String transfer();
}

abstract class Slot{
  void link(Plug plug);
}


// 由于某些特殊原因,手机连接接口
// 只能接收 TypeC 类型的接口
class Phone{

  void link(TypeC typeC) {
    String data = typeC.transfer();
    print(data);
  }

}

/**
 * 对象适配器
 */
class OTGAdapter extends TypeC{
  final USB usb;

  OTGAdapter(this.usb);

  @override
  String transfer() {
    return usb.transfer();
  }
}