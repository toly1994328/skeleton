import 'dart:math';

main(){
  Random _random = Random(2);
  int count = 10;
  List<double> nums = [] ;
  for(int i=0;i<count;i++){
    nums.add(_random.nextDouble());
  }
  print(nums.join('\n'));
}