abstract class Node{
  void parse(Context context);
}

class Context{
 String? currentToken;
 final String program;
 late Iterator<String> _it;

 Context(this.program){
   List<String>  _tokens = program.split(" ");
   _it = _tokens.iterator;
 }

 void skip(String token){
   if(currentToken==token){
     next();
   }
 }

  String? next() {
    if(_it.moveNext()){
      currentToken = _it.current;
    }else{
      currentToken = null;
    }
    return currentToken;
  }

}

class ProgramNode extends Node{
 late CommandListNode listNode;

  @override
  void parse(Context context) {
    context.skip('program');
    listNode = CommandListNode();
    listNode.parse(context);
  }

 @override
  String toString() {
    return 'ProgramNode{listNode: $listNode}';
 }
}

class CommandListNode extends Node{
  @override
  void parse(Context context) {
    // TODO: implement parse
  }
  
}

