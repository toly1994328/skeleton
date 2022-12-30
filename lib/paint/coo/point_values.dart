import 'package:flutter/cupertino.dart';

class PointValues extends ChangeNotifier{
  List<Offset> data = [];

  void add(Offset offset){
    data.add(offset);
    notifyListeners();
  }

  void clear(){
    data.clear();
    notifyListeners();
  }
}