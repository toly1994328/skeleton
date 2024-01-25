// 当一个类比较稳定，或在不修改类的基础上想添加新的功能。
// 此时如果通过 [继承] 的方式来拓展原类功能。

class Circle{
  void draw(){
    print("======绘制圆形=========");
  }
}

/// RedCircle 通过继承 Circle
/// 来拓展 设置红色 的功能
/// Circle
///    |--- RedCircle
class RedCircle extends Circle{
  @override
  void draw(){
    setPaint();
    super.draw();
  }

  void setPaint(){
    print("======设置红色=========");
  }
}

/// 如果又想拓展一个 [实心] 红色圆
/// RedFillCircle 通过继承 RedCircle
/// 来拓展 设置填充 的功能
/// Circle
///   |--- RedCircle
///     |--- RedFillCircle
class RedFillCircle extends RedCircle{
  @override
  void draw(){
    setStyle();
    super.draw();
  }

  void setStyle(){
    print("======设置填充=========");
  }
}


// 颜色、填充 对于圆来说是两个不同的维度
// 如果采用继承的方式来拓展功能，就会导致类的庞大
// 比如需要展示黄色就要在体系中添加三个类，
/// Circle 圆
///   |--- RedCircle 红色圆
///     |--- RedFillCircle 红色填充圆
///     |--- RedStorkCircle 红色边线圆
///   |--- YellowCircle 黄色圆
///     |--- YellowFillCircle 黄色填充圆
///     |--- YellowStorkCircle 黄色边线圆
///

/// 另外图形的形状也是一个维度，如果，现在系统中想要添加矩形的系列。
/// 就要再添加一支，这样对于一个维度的拓展，就要引入更多地类去实现，
/// 从而让性能的引入，产生类的爆炸式增长。这也是基于 [继承] 来拓展功能的弊端
/// Circle 圆
///   |--- RedCircle 红色圆
///     |--- RedFillCircle 红色填充圆
///     |--- RedStorkCircle 红色边线圆
///   |--- YellowCircle 黄色圆
///     |--- YellowFillCircle 黄色填充圆
///     |--- YellowStorkCircle 黄色边线圆
/// Rect 矩形
///   |--- RedRect 红色矩形
///     |--- RedFillRect 红色填充矩形
///     |--- RedStorkRect 红色边线矩形
///   |--- YellowRect 黄色矩形
///     |--- YellowFillRect 黄色填充矩形
///     |--- YellowStorkRect 黄色边线矩形
///
/// 如何让维度上的变化可以相对独立，这就是桥接模式需要解决的问题
/// 此时需要对维度进行抽象，通过组合的方式让不同维度的变化相对独立。