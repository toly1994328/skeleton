class SaleData {
  final String name;
  final num value;

  const SaleData({
    required this.name,
    required this.value,
  });

  static  List<SaleData> test = [
    SaleData(name: "Flutter 语言基础 - 梦始之地",value: 944),
    SaleData(name: "Flutter 渲染机制 - 聚沙成塔",value: 910),
    SaleData(name: "Flutter 布局探索 - 薪火相传",value: 1094),
    SaleData(name: "Flutter 滑动探索 - 珠联璧合",value: 1141),
    SaleData(name: "Flutter 动画探索 - 流光幻影",value: 1589),
    SaleData(name: "Flutter 手势探索 - 执掌天下",value: 1423),
    SaleData(name: "Flutter 绘制指南 - 妙笔生花",value: 2956),
  ];
}
