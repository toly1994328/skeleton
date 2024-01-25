class Digital{
  late String content;
  final int num;


  Digital(this.num){
    content = digitalRes[num];
  }

  void show(){
    print(content);
  }
}

List<String> digitalRes = [
  "·····######·····\n"
  "···##······##···\n"
  "···##······##···\n"
  "···##······##···\n"
  "···##······##···\n"
  "···##······##···\n"
  "·····######·····\n",

  "·······##·······\n"
  "···######·······\n"
  "·······##·······\n"
  "·······##·······\n"
  "·······##·······\n"
  "·······##·······\n"
  "···##########···\n"
];