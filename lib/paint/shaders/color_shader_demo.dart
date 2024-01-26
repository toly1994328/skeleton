import 'dart:ui';
import 'package:flutter/material.dart';

class ColorShaderDemo extends StatefulWidget {
  const ColorShaderDemo({super.key});

  @override
  State<ColorShaderDemo> createState() => _ColorShaderDemoState();
}

class _ColorShaderDemoState extends State<ColorShaderDemo> {
  FragmentShader? shader;

  @override
  void initState() {
    super.initState();
    _loadShader();
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Center(
      child: CustomPaint(
        size: const Size(500 * 0.8, 658 * 0.8),
        painter: ShaderPainter(
          shader: shader!,
        ),
      ),
    );
  }

  void _loadShader() async {
    String path = 'shaders/color.frag';
    FragmentProgram program = await FragmentProgram.fromAsset(path);
    shader = program.fragmentShader();
    setState(() {});
  }
}

class ShaderPainter extends CustomPainter {
  ShaderPainter({required this.shader});

  FragmentShader shader;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..shader = shader;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
