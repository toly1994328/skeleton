import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RectMaskShaderDemo extends StatefulWidget {
  const RectMaskShaderDemo({super.key});

  @override
  State<RectMaskShaderDemo> createState() => _RectMaskShaderDemoState();
}

class _RectMaskShaderDemoState extends State<RectMaskShaderDemo> {
  FragmentShader? shader;
  ui.Image? image;

  @override
  void initState() {
    super.initState();
    loadShader();
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null || image == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Center(
      child: CustomPaint(
        size: Size(500 * 0.8, 658 * 0.8),
        painter: ShaderPainter(shader: shader!, image: image!),
      ),
    );
  }

  void loadShader() async {
    FragmentProgram program =
        await FragmentProgram.fromAsset('shaders/eff_01_mask_rect.frag');
    shader = program.fragmentShader();
    setState(() {});
  }

  void loadImage() async {
    image = await loadImageFromAssets('assets/images/sabar.webp');
    setState(() {});
  }

  //读取 assets 中的图片
  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
  }
}

class ShaderPainter extends CustomPainter {
  ShaderPainter({required this.shader, required this.image});

  FragmentShader shader;
  ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setImageSampler(0, image);
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
