import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:skeleton/paint/shaders/components/page_shower.dart';
import 'package:skeleton/paint/shaders/custom_shader/custom_shader_painter.dart';
import '../custom_shader/size_image_shader_painter.dart';
import '../custom_shader/size_shader_painter.dart';

class LineDemoPanel extends StatelessWidget {
  final int activePage;
  final int maxPage;
  final double progress;
  final VoidCallback prev;
  final VoidCallback next;
  final ValueChanged<double> onProgressChange;
  final ui.Image image;
  final FragmentShader shader;

  const LineDemoPanel({
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
      msg:  activePage == 3
          ? 'progress:${progress.toStringAsFixed(3)}'
          : null,
    );
  }


  Widget _buildLine(int activeIndex) {
    if (activeIndex == 3) {
      return Column(
        children: [
          RepaintBoundary(
            child: CustomPaint(
              size: const Size(300, 300),
              painter: CustomShaderPainter(
                shader: shader,
                image: image,
                uProgress: progress

              ),
            ),
          ),
          Slider(
            value: progress,
            onChanged: onProgressChange,
          )
        ],
      );
    }
    return CustomPaint(
      size: const Size(300, 300),
      painter: SizeShaderPainter(shader: shader),
    );
  }
}
