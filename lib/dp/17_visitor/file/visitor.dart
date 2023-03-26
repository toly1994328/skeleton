import 'file.dart';

// 访问者的抽象类
// 访问者需要依赖访问的数据
abstract class Visitor {
  void visitFile(File file);

  void visitDir(Directory file);
}

// 接收访问者的访问接口
// 提供 accept 方法接收访问者
abstract class Element {
  void accept(Visitor visitor);
}


// Visitor 的实现类
// 处理数据元素的实现类，在回调方法中可以对元素进行具体的逻辑处理。
class PrintVisitor implements Visitor{

  String curDir = '';

  @override
  void visitDir(Directory directory) {
    print("$curDir/$directory");

    Iterator<Entry> it = directory.children.iterator;
    String saveDir = curDir;
    curDir = "$curDir/${directory.name}";
    while(it.moveNext()){
      // 触发访问
      it.current.accept(this);
    }
    curDir = saveDir;
  }

  @override
  void visitFile(File file) {
    print("$curDir/$file");
  }

}