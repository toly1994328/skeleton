main(){
  // CooConfig{maxX: 36.40000000000433, minX: -43.59999999999424, maxY: 45.99999999999974, minY: -34.00000000000016}
  double minX = -43.59999999999424;
  double maxX = 36.40000000000433;
  double step = 2.5;

   double span = maxX - minX ;
   double count = span/step;
   int scaleCount = 10;
   print(count);

  // double minScale = (minX~/step)*step;
  // if(minScale<minX){
  //   minScale+=step;
  // }
  // print(minX~/step);
  // for(double scale = minScale ;scale<=maxX;scale+=step){
  //   print(scale);
  // }

}