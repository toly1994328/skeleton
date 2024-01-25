import 'dart:math';

abstract class Product {
  void use();
}

abstract class Factory {
  Product create(String owner) {
    Product p = createProduct(owner);
    registerProduct(p);
    return p;
  }

  Product createProduct(String owner);

  void registerProduct(covariant Product product);
}

class IdCard extends Product {
  final String owner;
  final String id;

  IdCard(this.owner, this.id);

  @override
  void use() {
    print('$owner使用了 ID 卡: $id');
  }
}

class IDCardFactory extends Factory {
  final List<IdCard> _cards = [];
  final Random _random = Random();

  List<IdCard> get cards => _cards;

  @override
  Product createProduct(String owner) {
    String randomId = createId();
    return IdCard(owner, randomId);
  }

  String createId() {
    int genId = _random.nextInt(1000000000);
    String id = genId.toString().padLeft(10, '0');
    bool exist = cards.where((card) => card.id == id).isNotEmpty;
    if (!exist) {
      return id;
    }
    // 随机数重复,重新获取
    return createId();
  }

  @override
  void registerProduct(IdCard product) {
    _cards.add(product);
  }
}

void main() {
  Factory factory = IDCardFactory();
  Product zhang = factory.create("张三");
  Product lisi = factory.create("李四");
  zhang.use();
  lisi.use();
}
