import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:skeleton/paint/shaders/components/page_shower.dart';

import '../custom_shader/custom_shader_painter.dart';
import '../custom_shader/size_shader_painter.dart';

class SmoothDemoPanel extends StatelessWidget {
  final int activePage;
  final int maxPage;
  final double progress;
  final VoidCallback prev;
  final VoidCallback next;
  final ValueChanged<double> onProgressChange;
  final ui.Image image;
  final FragmentShader shader;

  const SmoothDemoPanel({
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
      child: _buildSmoothPanel(activePage),
      msg: activePage == 1 || activePage == 2
          ? 'progress:${progress.toStringAsFixed(3)}'
          : null,
    );
  }

  Widget _buildSmoothPanel(int activeIndex) {
    if (activeIndex == 1) {
      return Column(
        children: [
          RepaintBoundary(
            child: CustomPaint(
              size: const Size(300, 300),
              painter: CustomShaderPainter(
                shader: shader,
                uProgress: progress,
              ),
            ),
          ),
          Slider(value: progress, onChanged: onProgressChange)
        ],
      );
    }
    if (activeIndex == 2) {
      return Column(
        children: [
          RepaintBoundary(
            child: CustomPaint(
              size: const Size(300, 300),
              painter: CustomShaderPainter(
                shader: shader,
                image: image,
                uProgress: progress,
              ),
            ),
          ),
          Slider(value: progress, onChanged: onProgressChange)
        ],
      );
    }
    return CustomPaint(
      size: const Size(300, 300),
      painter: SizeShaderPainter(shader: shader),
    );
  }
}
