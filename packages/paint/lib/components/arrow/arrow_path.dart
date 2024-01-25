import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'port_path.dart';

abstract class AbstractPath {
  Path formPath();
}

class ArrowPath extends AbstractPath {
  final Offset start;
  final Offset end;
  final PortPath? head;
  final PortPath? tail;

  ArrowPath(
    this.start,
    this.end, {
    this.head,
    this.tail,
  });

  @override
  Path formPath() {
    Offset line = ( end-start);
    Offset center = start + line / 2;
    double length = line.distance;
    Rect lineZone = Rect.fromCenter(center: center, width: length, height: 2);
    Path linePath = Path()..addRect(lineZone);

    Path? headPath;
    Path? tailPath;
    double fixDx;
    double fixDy;

    if(head!=null){
      // 通过矩阵变换，让 linePath 以 center 为中心旋转 两点间角度
      Matrix4 lineM4 = Matrix4.translationValues(center.dx, center.dy, 0);
      lineM4.multiply(Matrix4.rotationZ(line.direction));
      lineM4.multiply(Matrix4.translationValues(-center.dx, -center.dy, 0));
      linePath = linePath.transform(lineM4.storage);

      double fixDx = head!.size.width / 2 * cos(line.direction);
      double fixDy = head!.size.height / 2 * sin(line.direction);
      headPath = head!.formPath(start);
      Path clipHeadZone = Path()..addRect(headPath.getBounds().translate(-head!.size.width/2, 0));

          Matrix4 headM4 = Matrix4.translationValues(fixDx, fixDy, 0);
      center = start;
      headM4.multiply(Matrix4.translationValues(center.dx, center.dy, 0));
      headM4.multiply(Matrix4.rotationZ(line.direction));
      headM4.multiply(Matrix4.translationValues(-center.dx, -center.dy, 0));
      headPath = headPath.transform(headM4.storage);
      clipHeadZone = clipHeadZone.transform(headM4.storage);
      linePath = Path.combine(PathOperation.reverseDifference, clipHeadZone,linePath);

    // return linePath;
    }


    if(tail!=null){
      tailPath = tail!.formPath(end);
      Path clipTailZone = Path()..addRect(tailPath.getBounds().translate(-tail!.size.width/2, 0));

      fixDx = tail!.size.width / 2 * cos(line.direction);
      fixDy = tail!.size.height / 2 * sin(line.direction);
      Matrix4 tailM4 = Matrix4.translationValues(-fixDx, -fixDy, 0);
      center = end;
      tailM4.multiply(Matrix4.translationValues(center.dx, center.dy, 0));
      tailM4.multiply(Matrix4.diagonal3Values(1, -1, 1));
      tailM4.multiply(Matrix4.rotationZ(-line.direction-pi));
      tailM4.multiply(Matrix4.translationValues(-center.dx, -center.dy, 0));
      tailPath = tailPath.transform(tailM4.storage);
      clipTailZone = clipTailZone.transform(tailM4.storage);
      linePath = Path.combine(PathOperation.reverseDifference, clipTailZone,linePath);

    }

    Path ret = linePath;

    if(headPath!=null){
      ret = Path.combine(PathOperation.union, ret, headPath);
    }

    if(tailPath!=null){
      ret = Path.combine(PathOperation.union, ret, tailPath);
    }

    return ret;
  }
}

class PortPath {
  // final Offset position;
  final Size size;
  PortPathBuilder portPath;

  PortPath(
    // this.position,
    this.size, {
    this.portPath = const TrianglePortPath.custom(),
  });

  Path formPath(Offset position) {
    Rect zone = Rect.fromCenter(
        center: position, width: size.width, height: size.height);
    return portPath.fromPathByRect(zone);
  }
}
