abstract class Aggregate{
  Iterator iterator();
}

abstract class Iterator{
  bool hasNext();
  Object next();
}

class BookShelfIterator implements Iterator{
  final BookShelf bookShelf;
   int _index = 0;

  BookShelfIterator(this.bookShelf);

  @override
  bool hasNext() {
    return _index<bookShelf.size;
  }

  @override
  Object next() {
   Book book = bookShelf.getBookAt(_index);
    _index++;
    return book;
  }

}

class BookShelf implements Aggregate{
  List<Book> _books =[];

  int get size => _books.length;

  Book getBookAt(int index)=> _books[index];

  void append(Book book){
    _books.add(book);
  }

  @override
  Iterator iterator() => BookShelfIterator(this);

}



class Book{
  final String name;
  Book(this.name);
}