import 'otc.dart';

void main(){
  // 现在有一个 usb 对象 和 phone 对象
  USB usb = USB("200G 学习资料");
  Phone phone = Phone();

  // 现在手机的 link 方法只能连接 TypeC 接口
  // phone.link(usb);

  // 通过 OTGAdapter 适配器，手机可以进行连接
  OTGAdapter adapter = OTGAdapter(usb);
  phone.link(adapter);
}