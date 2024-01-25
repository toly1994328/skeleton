import 'book.dart';

void main(){
  // 实例化聚合对象
  BookShelf shelf = BookShelf();
  shelf.add(Book("《幻将录》"));
  shelf.add(Book("《永恒传说》"));
  shelf.add(Book("《风神传》"));
  shelf.add(Book("《封妖志》"));

  Iterator it = shelf.iterator();
  while(it.hasNext()){
   Book book = it.next();
   print(book.name);
  }
}