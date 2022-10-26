main(){
  Duration duration = Duration(hours: 2,minutes:18,seconds: 29,milliseconds: 500);

  print(duration.inHours); // 2
  print(duration.inMinutes); // 2*60+10 = 130
  print(duration.inSeconds); // (2*60+10)*60+20 = 7820
  print(duration.inMilliseconds); // ((2*60+10)*60+20)*1000+500 = 7820500

  int minus = duration.inMinutes%60;
  int second = duration.inSeconds%60;
  int milliseconds = duration.inMilliseconds%1000;
  print(minus);
  print(second);
  print(milliseconds);
}