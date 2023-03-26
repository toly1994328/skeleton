class Markdown{  //[ Adaptee] 被适配者
  final String msg;

  Markdown(this.msg);

  // 现已有 Markdown 系统中，存在 boldMessage 方法，将消息加粗
  String boldMessage(){
    String boldMsg = '**$msg**';
    return boldMsg;
  }
}

// 在 Printer 系统中，存在 bold 接口，将消息加粗
abstract class Printer{ //[ Target] 适配目标
  String bold();
}

// 现在客户端的某处需要使用 Printer 接口
// 而不是 Markdown 系统
void show(Printer printer){ // [ Client] 请求者
  String bold = printer.bold();
  print(bold);
}

// 使用类适配器
// 现在 Printer 系统需要使用 Markdown 系统的 boldMessage 能力，又不想破坏 Markdown 本身
// 可以通过适配器，集成自 Markdown 类可以使用其功能，在实现 Printer ,让其可以视为 Printer 对象
class MarkdownAdapter extends Markdown implements Printer{ //[ Adapter] 适配者
  MarkdownAdapter(super.msg);

  @override
  String bold() => boldMessage();
}


void main(){
  // 使用类适配器
  // 在客户端中通过 MarkdownAdapter 得到 Printer 对象
  // 屏蔽了使用者对 Markdown 系统的感知，
  // 同时也能在内部依赖 Markdown 系统功能完成功能需求
  Printer printer = MarkdownAdapter("Toly1994");
  show(printer);

  // 使用对象类适配器
  // MarkdownAdapter2 持有 Markdown 对象，来完成对于的功能
  // 所以使用者需要有 Markdown 对象，才能使用适配器
  Markdown markdown = Markdown("Toly1994");
  Printer printer2 = MarkdownAdapter2(markdown);
  show(printer2);
}

// 使用对象适配器
// [委托] : 在类中某方法实现的逻辑，交由其他实例处理。
class MarkdownAdapter2 implements Printer{
  final Markdown markdown;

  MarkdownAdapter2(this.markdown);

  @override
  String bold() => markdown.boldMessage();
}