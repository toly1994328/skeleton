// import 'dart:math';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;
//
// class Playground2 extends CustomPainter {
//   final ui.Image? image;
//   final ValueListenable<Matrix4> matrix;
//
//   Playground2(this.image):super();
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..style = PaintingStyle.stroke;
//     canvas.drawRect(Offset.zero & size, paint);
//
//     if (image != null) {
//       canvas.save();
//       // Matrix4 matrix = Matrix4.translationValues(100, 0, 0);
//       //
//       // Matrix4 translateX = Matrix4.translationValues(100, 0, 0);
//       // Matrix4 rotate90 = Matrix4.rotationZ(pi/2);
//       //
//       // matrix.multiply(rotate90);
//
//       // // Matrix4 translateY = Matrix4.translationValues(0, 0, 0);
//       //
//       // Matrix4 rotate90Matrix = Matrix4.identity();
//       // rotate90Matrix.translate(50.0, 50.0,);
//       // rotate90Matrix.multiply(rotate90);
//       // rotate90Matrix.translate(-50.0, -50.0,);
//
//       canvas.transform(matrix.value.storage);
//       // canvas.translate(100*animation.value, 0);
//       drawCarWithRange(canvas, paint);
//       canvas.restore();
//       // drawCarImageRect(canvas, paint);
//     }
//   }
//
//   void drawCarWithRange(Canvas canvas, Paint paint) {
//     Rect zone =
//         Rect.fromLTRB(0, 0, image!.width.toDouble(), image!.width.toDouble());
//     paint.color = Colors.orange;
//     canvas.drawRect(zone, paint);
//
//     // 绘制图片
//     canvas.drawImage(image!, Offset.zero, paint);
//     canvas.drawCircle(Offset(50, 50), 5, Paint()..color=Colors.redAccent);
//   }
//
//   void drawCarImageRect(Canvas canvas, Paint paint) {
//     // 让图片资源全部区域， 填充到 dst 画板矩形域中
//     {
//       canvas.translate(100, 0);
//       Rect src = Rect.fromLTRB(
//           0, 0, image!.width.toDouble(), image!.height.toDouble());
//       Rect dst = Rect.fromLTRB(0, 0, 50, 50);
//       canvas.drawImageRect(image!, src, dst, paint);
//       paint.color = Colors.orange;
//       canvas.drawRect(dst, paint);
//     }
//
//     {
//       canvas.translate(0, 50);
//       // Rect src = Rect.fromLTRB(
//       //     0, 0, image!.width.toDouble()/2, image!.width.toDouble()/2);
//       double imageWidth = image!.width.toDouble();
//       double imageHeight = image!.height.toDouble();
//       Offset center = Offset(imageWidth / 2, imageHeight / 2);
//       Rect src = Rect.fromCenter(
//           center: center, width: imageWidth / 2, height: imageHeight / 2);
//       Rect dst = Rect.fromLTRB(0, 0, 50, 50);
//       canvas.drawImageRect(image!, src, dst, paint);
//       paint.color = Colors.orange;
//       canvas.drawRect(dst, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
