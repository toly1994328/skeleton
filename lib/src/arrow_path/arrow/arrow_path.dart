import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skeleton/src/arrow_path/arrow/port_path.dart';

abstract class AbstractPath {
  Path formPath();
}

class ArrowPath extends AbstractPath {
  final PortPath head;
  final PortPath tail;

  ArrowPath({required this.head, required this.tail});

  @override
  Path formPath() {
    Offset line = (tail.position - head.position);
    Offset center = head.position + line / 2;
    double length = line.distance - head.size.width / 2 - tail.size.width / 2;
    Rect lineZone = Rect.fromCenter(center: center, width: length, height: 1);
    Path linePath = Path()..addRect(lineZone);

    // 通过矩阵变换，让 linePath 以 center 为中心旋转 两点间角度
    Matrix4 lineM4 = Matrix4.translationValues(center.dx, center.dy, 0);
    lineM4.multiply(Matrix4.rotationZ(line.direction));
    lineM4.multiply(Matrix4.translationValues(-center.dx, -center.dy, 0));
    linePath = linePath.transform(lineM4.storage);

    double fixDx = head.size.width / 2 * cos(line.direction);
    double fixDy = head.size.height / 2 * sin(line.direction);
    Path headPath = head.formPath();
    Path tailPath = tail.formPath();

    Matrix4 headM4 = Matrix4.translationValues(fixDx, fixDy, 0);
    center = head.position;
    headM4.multiply(Matrix4.translationValues(center.dx, center.dy, 0));
    headM4.multiply(Matrix4.rotationZ(line.direction));
    headM4.multiply(Matrix4.translationValues(-center.dx, -center.dy, 0));
    headPath = headPath.transform(headM4.storage);

    Matrix4 tailM4 = Matrix4.translationValues(-fixDx, -fixDy, 0);
    center = tail.position;
    tailM4.multiply(Matrix4.translationValues(center.dx, center.dy, 0));
    tailM4.multiply(Matrix4.rotationZ(line.direction - pi));
    tailM4.multiply(Matrix4.translationValues(-center.dx, -center.dy, 0));
    tailPath = tailPath.transform(tailM4.storage);

    Path temp = Path.combine(PathOperation.union, linePath, headPath);
    return Path.combine(PathOperation.union, temp, tailPath);
  }
}

class PortPath extends AbstractPath {
  final Offset position;
  final Size size;
  PortPathBuilder portPath;

  PortPath(
    this.position,
    this.size, {
    this.portPath = const CustomPortPath(),
  });

  @override
  Path formPath() {
    Rect zone = Rect.fromCenter(
        center: position, width: size.width, height: size.height);
    return portPath.fromPathByRect(zone);
  }
}
