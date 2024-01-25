//统一的聚合接口 将客户端和具体聚合解耦
abstract class Aggregate<E>{
  Iterator iterator();
  void add(E book);
  int get size;
}

// 迭代器接口
abstract class Iterator<E>{
  bool hasNext();
  E next();
}

// 迭代器实现类
class BookShelfIterator implements Iterator<Book>{

  // 由于迭代器在实现功能过程中需要访问聚合对象，
  // 所以可以通过构造方法持有聚合对象，也可以仅持有聚合的数据。
  final BookShelf _bookShelf;
  int _index = 0;

  BookShelfIterator(this._bookShelf);

  @override
  bool hasNext() {
    return _index<_bookShelf.size;
  }

  @override
  Book next() {
    Book book = _bookShelf.getBookAt(_index);
    _index++;
    return book;
  }
}

// 聚合对象实现类
class BookShelf implements Aggregate<Book>{

  final List<Book> _books = [];

  @override
  int get size => _books.length;

  Book getBookAt(int index)=> _books[index];

  @override
  Iterator<Book> iterator() => BookShelfIterator(this);

  @override
  void add(Book book) {
    _books.add(book);
  }

}

// 聚合对象中的单体元素
class Book{
  final String name;
  Book(this.name);
}