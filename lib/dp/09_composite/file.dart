abstract class Entry{
  String getName();
  int getSize();

  Entry add(Entry entry){
    throw Exception('add entry error');
  }

  void list(String prefix);

  @override
  String toString() {
    return '${getName()} (${getSize()})';
  }
}

class File extends Entry{
  final String name;
  final int size;

  File(this.name, this.size);

  @override
  void list(String prefix) {
    print("$prefix/$this");
  }

  @override
  String getName() {
    return name;
  }

  @override
  int getSize() {
    return size;
  }
}

class Directory extends Entry{
  final String name;
  final List<Entry> _children = [];

  Directory(this.name);

  @override
  String getName() {
   return name;
  }

  @override
  int getSize() {
    Iterator<Entry> it = _children.iterator;
    int size = 0;
    while(it.moveNext()){
      size += it.current.getSize();
    }
    return size;
  }

  @override
  Entry add(Entry entry) {
   _children.add(entry);
   return this;
  }

  @override
  void list(String prefix) {
    print('$prefix/$this');
    Iterator<Entry> it = _children.iterator;
    while(it.moveNext()){
      it.current.list('$prefix/$name');
    }
  }
}

void main(){
  Directory root = Directory('root');
  Directory bin = Directory('bin');
  Directory tmp = Directory('tmp');
  Directory usr = Directory('usr');

  root.add(bin);
  root.add(tmp);
  root.add(usr);

  File hello = File('hello.txt',3000);
  File word = File('word.exe',3000);
  File cc = File('cc.exe',1000);
  usr.add(hello);
  usr.add(cc);
  bin.add(word);
  root.list('');
}