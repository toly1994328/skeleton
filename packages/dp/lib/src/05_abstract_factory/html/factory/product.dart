// 抽象产品 Element
abstract class Element {
  final String caption;

  Element(this.caption);

  String makeHtml();
}

// 抽象产品 Link
abstract class Link extends Element{
  final String url;

  Link(super.caption,this.url);
}

// 抽象产品 Container
abstract class Container extends Element{
  final List<Element> _elements = [];

  List<Element> get elements =>_elements;

  Container(super.caption);

  void append(Element element){
    _elements.add(element);
  }
}

abstract class Page{
 final String title;
 final String author;
 final List<Element> _elements = [];

 Page(this.title, this.author);

 List<Element> get elements =>_elements;

 void append(Element element){
   _elements.add(element);
 }

 void output(){
   String content = makeHtml();
   print(content);
 }

 String makeHtml();
}

class ListLink extends Link{
  ListLink(super.caption, super.url);

  @override
  String makeHtml() {
    return """<li><a href= "$url">$caption</a></li>\n""";
  }
}

class ListContainer extends Container{
  ListContainer(super.caption);

  @override
  String makeHtml() {
    String result = '';
    result +="<li>\n";
    result +="$caption\n";
    result +="<ul>\n";
    Iterator<Element> it = elements.iterator;
    while(it.moveNext()){
      Element e = it.current;
      result += e.makeHtml();
    }
    result +="</ul>\n";
    result +="</li>\n";
    return result;
  }
}

class ListPage extends Page{
  ListPage(super.title, super.author);

  @override
  String makeHtml() {
    String result = '';
    result +="<html><head><title>$title</title></head>\n";
    result +="<body>\n";
    result +="<h1>$title</h1>\n";
    result +="</ul>\n";
    Iterator<Element> it = elements.iterator;
    while(it.moveNext()){
      Element e = it.current;
      result += e.makeHtml();
    }
    result +="</ul>\n";
    result +="<hr><address>$author</address>\n";
    result +="</body></html>\n";
    return result;
  }

}