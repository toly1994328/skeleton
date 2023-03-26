import 'product.dart';

abstract class Factory {
  // Factory static getFactory(Type classType){
  //     Factory factory;
  //     switch(classType){
  //       case Link:
  //
  //     }
  // }

  Link createLink(String caption, String url);

  Container createContainer(String caption);

  Page createPage(String title, String author);
}

class ListFactory extends Factory {
  @override
  Container createContainer(String caption) {
    return ListContainer(caption);
  }

  @override
  Link createLink(String caption, String url) {
    return ListLink(caption, url);
  }

  @override
  Page createPage(String title, String author) {
    return ListPage(title, author);
  }
}
