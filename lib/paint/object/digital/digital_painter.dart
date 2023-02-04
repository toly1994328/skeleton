import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DigitalPainter extends CustomPainter {
  final int value;


  DigitalPainter({required this.value});

  final Paint _bgPainter = Paint()..color = Colors.grey.withOpacity(0.1);
  final Paint _mainPainter = Paint()..style=PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(Offset.zero & size, _bgPainter);
    Path path = digitalPath(size.width/104,value);
    canvas.drawPath(path, _mainPainter);
  }

  Path digitalPath(double rate, int value){
    Map<int,Path> map = {};
    double strokeWidth = 26*rate;
    double width = 104*rate;
    double height = 169*rate;
    double gap = 5*rate;
    double angle = 43;

    Path path1 = Path()
      ..moveTo(gap, 0)
      ..relativeLineTo(width-gap*2 , 0)
      ..relativeLineTo(-strokeWidth/tan(angle*pi/180), strokeWidth)
      ..lineTo(strokeWidth/tan(angle*pi/180)+gap, strokeWidth)..close();

    Path path2 = Path()
      ..moveTo(0, 2*rate)
      ..lineTo(0 , 74*rate)
      ..lineTo(13*rate , 83*rate)
      ..lineTo(26*rate , 71*rate)
      ..lineTo(26*rate , 27*rate)
      ..close();

    Matrix4 mirrorY =  Matrix4.identity();
    mirrorY.translate(width/2,0.0);
    mirrorY.scale(-1.0,1.0,0.0);
    mirrorY.translate(-width/2,0.0);
    Path path4 = path2.transform(mirrorY.storage);

    Matrix4 mirrorX = Matrix4.identity();
    mirrorX.translate(0.0,height/2);
    mirrorX.scale(1.0,-1.0,0.0);
    mirrorX.translate(0.0,-height/2);

    Path path5 = path2.transform(mirrorX.storage);
    Path path7 = path5.transform(mirrorY.storage);
    Path path6 = path1.transform(mirrorX.storage);

    Path path3 = Path()
      ..moveTo(18*rate, 84*rate)
      ..lineTo(31*rate , 97*rate)
      ..lineTo(73*rate , 97*rate)
      ..lineTo(86*rate , 85*rate)
      ..lineTo(75*rate , 74*rate)
      ..lineTo(31*rate , 74*rate)
      ..close();
    map[1] = path1;
    map[2] = path2;
    map[3] = path3;
    map[4] = path4;
    map[5] = path5;
    map[6] = path6;
    map[7] = path7;

   List<Path> paths = digitals[value.toString()]!.map<Path>((value) => map[value]!).toList();
    return combineAll(paths);
  }

  Path combineAll(List<Path> paths,
      {PathOperation operation = PathOperation.union}) {
    if (paths.isEmpty) return Path();
    if (paths.length <= 1) return paths.first;
    Path result = paths.first;
    for (int i = 1; i < paths.length; i++) {
      result = Path.combine(operation, paths[i], result);
    }
    return result;
  }


  @override
  bool shouldRepaint(covariant DigitalPainter oldDelegate) {
   return true;
    // return oldDelegate.value != value;
  }
}

Map<String,List<int>> digitals = {
  '0': [1,2,4,5,6,7],
  '1': [4,7],
  '2': [1,4,3,5,6],
  '3': [1,4,3,6,7],
  '4': [2,3,4,7],
  '5': [1,2,3,6,7],
  '6': [1,2,3,5,6,7],
  '7': [1,4,7],
  '8': [1,2,3,4,5,6,7],
  '9': [1,2,3,4,6,7],
};