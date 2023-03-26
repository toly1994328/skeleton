class Director {
  final Builder builder;

  Director(this.builder);

  void construct() {
    builder.makeTitle('设计模式');
    builder.makeString('软件设计模式（Design pattern），又称设计模式，是一套被反复使用、多数人知晓的、经过分类编目的、代码设计经验的总结。使用设计模式是为了可重用代码、让代码更容易被他人理解、保证代码可靠性、程序的重用性。');
    builder.makeList([
      '单例模式 (Singleton)',
      '原型模式 (Prototype)',
      '工厂方法模式 (Factory Method)',
      '抽象工厂模式 (Abstract Factory)',
      '建造者模式 (Builder)',
    ]);
    builder.close();
  }
}

abstract class Builder {
  void makeTitle(String title);

  void makeString(String content);

  void makeList(List<String> item);

  void close();

  String build();
}

class TextBuilder extends Builder{
  String _result = '';

  @override
  void close() {
    _result += '===============END==================\n';
  }

  @override
  void makeList(List<String> item) {
    for(int i=0;i<item.length;i++){
      _result+="· ${item[i]}\n";
    }
  }

  @override
  void makeString(String content) {
   _result+="$content\n";
  }

  @override
  void makeTitle(String title) {
    _result += '===============TITLE==================\n';
    _result+="【$title】\n";
  }

  String build(){
    return _result;
  }
}

void main(){
  Builder builder = TextBuilder();
  Director director= Director(builder);
  director.construct();
  String content = builder.build();
  print(content);
}