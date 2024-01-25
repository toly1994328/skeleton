
import 'factory/factory.dart';
import 'factory/product.dart';

void main(){
  Factory factory = ListFactory();
  Link people = factory.createLink("人民日报", 'http://www.people.com.cn');
  Link gmw = factory.createLink("光明日报", 'http://www.gmw.cn');


  Container container = factory.createContainer('日报');
  container.append(people);
  container.append(gmw);

  Page page = factory.createPage('toly',"1234");
  page.append(container);
  String result = page.makeHtml();
  print(result);
}