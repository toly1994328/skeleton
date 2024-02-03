import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:skeleton/src/anim/run/playground.dart';

class RunCar1 extends StatefulWidget {
  const RunCar1({Key? key}) : super(key: key);

  @override
  State<RunCar1> createState() => _RunCar1State();
}

class _RunCar1State extends State<RunCar1> with SingleTickerProviderStateMixin {
  ui.Image? _image;
  late AnimationController _controller;

  // ValueNotifier<Matrix4> _matrix = ValueNotifier(Matrix4.identity()) ;
  late Animation<Matrix4> _matrix;
  Matrix4 lastMatrix = Matrix4.identity();
  TextEditingController _durationCtrl = TextEditingController(text: '1000');

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    // _controller.addListener(_ticker);
    _matrix = Matrix4Tween(begin: Matrix4.identity(), end: Matrix4.identity())
        .animate(_controller);
    _loadImage();
  }

  void _ticker() {}

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
              size: Size(400, 400),
              painter: Playground(_image, _matrix),
              // painter: Playground2(_image),
            ),
            _buildTools(),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  //    // Matrix4 matrix4 = Matrix4.identity();
  //     // matrix4.translate(50.0+100*animation.value, 50.0);
  //     // matrix4.rotateZ(pi/2);
  //     // matrix4.translate(-50.0, -50.0);
  //     // Matrix4 matrix4 = Matrix4.rotationZ();

  Widget _buildTools() {
    return Row(
      children: [
        // Expanded(
        //     child: TextField(
        //   controller: _durationCtrl,
        // )),
        const SizedBox(
          width: 24,
        ),
        GestureDetector(
          onTap: _resetMatrix,
          child: Icon(
            Icons.refresh,
            color: Colors.blue,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        GestureDetector(
          onTap: _rotate,
          child: Icon(
            Icons.rotate_90_degrees_ccw,
            color: Colors.blue,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        GestureDetector(
          onTap: _run,
          child: Icon(
            Icons.run_circle_outlined,
            color: Colors.blue,
          ),
        )
      ],
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

  void _rotate() {

    int? inputDuration = int.tryParse(_durationCtrl.text);

    if (inputDuration != null) {
      _controller.duration = Duration(milliseconds: inputDuration);
    }

    Matrix4 rotate90 = Matrix4.rotationZ(pi/2);
    Matrix4 center = Matrix4.translationValues(50.0, 50.0, 0);
    Matrix4 centerBack = Matrix4.translationValues(-50.0, -50.0, 0);
    Matrix4 _temp = lastMatrix.clone();
    _temp.multiply(center);
    _temp.multiply(rotate90);
    Matrix4 end = _temp.multiplied(centerBack);

    _matrix = Matrix4Tween(begin: end, end: end).animate(_controller);
    lastMatrix = end;
    setState(() {});
    // _controller.forward(from: 0);
  }

  void _run() {


    int? inputDuration = int.tryParse(_durationCtrl.text);

    if (inputDuration != null) {
      _controller.duration = Duration(milliseconds: inputDuration);
    }



    Matrix4 translateX = Matrix4.translationValues(100, 0, 0);
    Matrix4 end = lastMatrix.multiplied(translateX);

    _matrix =
        Matrix4Tween(begin: lastMatrix, end: end).animate(_controller);
    lastMatrix = end;
    setState(() {});
    _controller.forward(from: 0);
  }
  void _resetMatrix() {
    // _matrix.value = Matrix4.identity();
  }
}
