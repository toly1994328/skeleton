import 'problem.dart';

// 处理者抽象接口
abstract class Handler {
  final String name;
  Handler? next;

  Handler(this.name);

  Handler setNext(Handler handler) {
    next = handler;
    return next!;
  }

  void handle(Problem problem){
    if(resolve(problem)){
      done(problem);
    }else if(next!=null){
      next!.handle(problem);
    }else{
      fail(problem);
    }
  }

  bool resolve(Problem problem);

  void done(Problem problem){
    print("问题已由 ${this.name} 解决.");
  }

  void fail(Problem problem){
    print("问题为解决: ${problem.code}");
  }


}

// 处理者的实现类
// 什么都不做的处理器，总会在解决问题时抛给下一个处理者。
class NoHandler extends Handler{
  NoHandler(super.name);

  @override
  bool resolve(Problem problem) {
    return false;
  }
}

// 处理 404 异常
class NoAssetsHandler extends Handler{
  NoAssetsHandler(super.name);

  @override
  bool resolve(Problem problem) {
    if(problem.code==404){
      print("=====资源不存在，已处理告知===========");
      return true;
    }
    return false;
  }
}

// 处理 404 异常
class InnerErrorHandler extends Handler{
  InnerErrorHandler(super.name);

  @override
  bool resolve(Problem problem) {
    if(problem.code==500){
      print("=====服务器异常，已处理告知===========");
      return true;
    }
    return false;
  }
}

