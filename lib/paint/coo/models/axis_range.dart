class AxisRange {
  final double maxX;
  final double minX;
  final double maxY;
  final double minY;

  const AxisRange({
    this.maxX = 1.0,
    this.minX = -1.0,
    this.maxY = 1.0,
    this.minY = -1.0,
  });

  List<double> xScales(double step){
    // 根据坐标轴范围，计算出需要出现的刻度
    // 比如坐标轴范围 x: (-7.8，7.8) 步长 2.5
    //
    // double span = maxX - minX ;
    // double count = span/step;
    // if(count)
    // step = step*5;
    double minScale = (minX~/step)*step;
    if(minScale<minX){
      minScale+=step;
    }
    List<double> result = [];
    for(double scale = minScale ;scale<=maxX;scale+=step){
      result.add(scale);
    }
    return result;
  }

  List<double> yScales(double step){
    // 根据坐标轴范围，计算出需要出现的刻度
    // 比如坐标轴范围 x: (-7.8，7.8) 步长 2.5
    //
    // step = step*5;
    double minScale = (minY~/step)*step;
    if(minScale<minY){
      minScale+=step;
    }
    List<double> result = [];
    for(double scale = minScale ;scale<=maxY;scale+=step){
      result.add(scale);
    }
    return result;
  }

  double get xSpan => maxX - minX;
  double get ySpan => maxY - minY;

  @override
  String toString() {
    return 'CooConfig{maxX: $maxX, minX: $minX, maxY: $maxY, minY: $minY}';
  }
}
