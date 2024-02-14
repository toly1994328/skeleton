import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageShaderDemo extends StatefulWidget {
  const ImageShaderDemo({super.key});

  @override
  State<ImageShaderDemo> createState() => _ImageShaderDemoState();
}

class _ImageShaderDemoState extends State<ImageShaderDemo> {
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
        size: Size(1280 * 0.25, 1706 * 0.25),
        painter: ShaderPainter(shader: shader!, image: image!),
      ),
    );
  }

  void loadShader() async {
    FragmentProgram program =
        await FragmentProgram.fromAsset('shaders/image.frag');
    shader = program.fragmentShader();
    setState(() {});
  }

  void loadImage() async {
    image = await loadImageFromAssets('assets/images/ac.webp');
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
