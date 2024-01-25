// 定义接口，提供一致性操作
abstract class Rentable {
  void rent();
}

//  房东:真实角色
class Host implements Rentable {
  @override
  void rent() {
    print("出租房子");
  }
}


// 代理这实现 [真实对象] 接口，并持有真实对象成员
class RentProxy implements Rentable {
  final Host host;

  RentProxy(this.host);

  @override
  void rent() {
    add();
    sign();
    host.rent();
  }

  void sign(){
    print("签组合合同");
  }

  void add(){
    print("打租房广告");
  }
}