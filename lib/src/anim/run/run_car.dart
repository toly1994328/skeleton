import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:skeleton/src/anim/run/playground.dart';

import 'control_tools.dart';

class RunCar extends StatefulWidget {
  const RunCar({Key? key}) : super(key: key);

  @override
  State<RunCar> createState() => _RunCarState();
}

class _RunCarState extends State<RunCar> with SingleTickerProviderStateMixin {
  ui.Image? _image;

  final ValueNotifier<Matrix4> _matrix = ValueNotifier(Matrix4.identity());
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _loadImage();
    _initTween();
  }

  late Matrix4Tween moveTween;
  late Matrix4Tween rotateTween;

  void _initTween() {
    rotateTween = Matrix4Tween(begin: Matrix4.rotationZ(0), end: Matrix4.rotationZ(pi/2));
    moveTween = Matrix4Tween(begin: Matrix4.translationValues(0, 0, 0), end: Matrix4.translationValues(100, 0, 0));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(
              size: const Size(400, 400),
              painter: Playground(_image, _matrix),
            ),
            ControlTools(
              onReset: _onReset,
              onMove: _onMove,
              onRotate: _onRotate,
            ),
          ],
        ),
      ),
    );
  }

  //读取 assets 中的图片
  Future<ui.Image>? loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
  }

  void _loadImage() async {
    _image = await loadImageFromAssets('assets/images/car.png');
    setState(() {});
  }

  final Matrix4 moveCenter = Matrix4.translationValues(50, 50, 0);
  final Matrix4 moveBack = Matrix4.translationValues(-50, -50, 0);

  void _onRotate() {
    Matrix4 start  = _matrix.value.clone();
    Animation<Matrix4> m4Tween = rotateTween.animate(_controller);
    m4Tween.addListener(() {
      Matrix4 rotate = moveCenter.multiplied(m4Tween.value).multiplied(moveBack);
      _matrix.value = start.multiplied(rotate);
    });
    _controller.forward(from: 0);
  }

  void _onMove() {
    Matrix4 start = _matrix.value.clone();
    Animation<Matrix4> m4Anima = moveTween.animate(_controller);
    m4Anima.addListener(() => _matrix.value = start.multiplied(m4Anima.value));
    _controller.forward(from: 0);
  }

  void _onReset() {
    _matrix.value = Matrix4.identity();
  }
}
