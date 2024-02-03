import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GradationDemo extends StatefulWidget {
  const GradationDemo({super.key});

  @override
  State<GradationDemo> createState() => _GradationDemoState();
}

class _GradationDemoState extends State<GradationDemo> {
  FragmentShader? shader;

  @override
  void initState() {
    super.initState();
    loadShader();
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null ) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Center(
      child: CustomPaint(
        size: Size(500 * 0.8, 658 * 0.8),
        painter: ShaderPainter(shader: shader!),
      ),
    );
  }

  void loadShader() async {
    FragmentProgram program =
        await FragmentProgram.fromAsset('shaders/gradation.frag');
    shader = program.fragmentShader();
    setState(() {});
  }


  //读取 assets 中的图片
  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
  }
}

class ShaderPainter extends CustomPainter {
  ShaderPainter({required this.shader});

  FragmentShader shader;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    final paint = Paint()..shader = shader;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
