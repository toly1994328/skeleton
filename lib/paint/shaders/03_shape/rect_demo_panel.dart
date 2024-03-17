import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:skeleton/paint/shaders/components/page_shower.dart';
import '../custom_shader/size_image_shader_painter.dart';
import '../custom_shader/size_shader_painter.dart';

class RectDemoPanel extends StatelessWidget {
  final int activePage;
  final int maxPage;
  final double progress;
  final VoidCallback prev;
  final VoidCallback next;
  final ValueChanged<double> onProgressChange;
  final ui.Image image;
  final FragmentShader shader;

  const RectDemoPanel({
    super.key,
    required this.activePage,
    required this.maxPage,
    required this.prev,
    required this.next,
    required this.progress,
    required this.shader,
    required this.onProgressChange,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return PageShower(
      activePage: activePage,
      prev: prev,
      next: next,
      maxPage: maxPage,
      child: _buildLine(activePage),
    );
  }


  Widget _buildLine(int activeIndex) {
    if (activeIndex == 4) {
      return RepaintBoundary(
        child: CustomPaint(
          size: const Size(300, 300),
          painter: SizeImageShaderPainter(
            shader: shader,
            image: image,
          ),
        ),
      );
    }
    return CustomPaint(
      size: const Size(300, 300),
      painter: SizeShaderPainter(shader: shader),
    );
  }
}
