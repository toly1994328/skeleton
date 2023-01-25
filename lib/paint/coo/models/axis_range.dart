import 'dart:math';
import 'dart:ui';

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

  List<double> xScales(double step,Size size,double scaleWidth){
    List<double> result = [];
    double rate = (maxX - minX)/size.width;
    double step = scaleWidth*rate;

    int i =0;
    for(double scale = 0;scale>=minX-step;scale-=step){
      result.add(scale);
    }


    for(double scale = 0 ;scale<=maxX+step;scale+=step){
      result.add(scale);
    }

    return result;
  }

  List<double> yScales(double step,Size size,scaleHeight){
    // 根据坐标轴范围，计算出需要出现的刻度
    // 比如坐标轴范围 x: (-7.8，7.8) 步长 2.5
    //
    // step = step*5;
    // int count = ySpan~/step;
    // if(count!=0){
    //   double len = size.height/count;
    //   int scale = 100~/len;
    //   step = step*scale;
    // }
    // double tryStep(){
    //   double rate1 = ySpan/step;
    //   double aSpan = size.height/rate1;
    //   if(aSpan>60&&aSpan<120){
    //     return step;
    //   }
    //   if(aSpan<=60){
    //     step = step *2;
    //     return tryStep();
    //   }
    //   if(aSpan>=120){
    //     step = step /2;
    //     return tryStep();
    //   }
    //   return step;
    // }
    //
    //
    // step = tryStep();

    List<double> result = [];
    double rate = (maxX - minX)/size.height;
    double step = scaleHeight*rate;
    for(double scale = 0 ;scale>=minY-step;scale-=step){
      result.add(scale);
    }

    for(double scale = 0 ;scale<=maxY+step;scale+=step){
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
