import 'dart:ui';
import 'package:components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/switch_tabs.dart';
import 'f2_painter.dart';

class FancyPage extends StatefulWidget {
  const FancyPage({super.key});

  @override
  State<FancyPage> createState() => _FancyPageState();
}

class _FancyPageState extends State<FancyPage> {
  FragmentShader? shader;

  List<Map<String, String>> data = [
    {
      'file': 'shaders/fancy_01.frag',
      'title': '多色渐变',
    },
    {
      'file': 'shaders/fancy_02_length.frag',
      'title': '长度',
    },
    {
      'file': 'shaders/fancy_03.frag',
      'title': '彩色',
    },
    {
      'file': 'shaders/fancy_04.frag',
      'title': '群色闪耀',
    },
    {
      'file': 'shaders/fancy_05.frag',
      'title': '波浪线',
    },
  ];

  String _activeTab = 'shaders/fancy_01.frag';

  @override
  void initState() {
    super.initState();
    _loadShader(_activeTab);
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: SwitchTabs(
          data: data,
          activeTab: _activeTab,
          onTabChanged: _onChangeShader,
        )),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: _buildByTab(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 10),
          child: Text(
            'shader 文件: $_activeTab',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        Expanded(
            child: CodeView(
          path: 'assets/code/$_activeTab',
        )),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  void _loadShader(String path) async {
    FragmentProgram program = await FragmentProgram.fromAsset(path);
    shader = program.fragmentShader();
    setState(() {});
  }

  void _onChangeShader(String value) {
    setState(() {
      _activeTab = value;
    });
    _loadShader(_activeTab);
  }

  double time = 0;

  Widget _buildByTab() {
    if (_activeTab == 'shaders/fancy_02_length.frag'
        || _activeTab == 'shaders/fancy_03.frag'
        || _activeTab == 'shaders/fancy_04.frag'
        || _activeTab == 'shaders/fancy_05.frag'
    ) {
      return Column(
        children: [
          CustomPaint(
            size: const Size(300, 300),
            painter: F2ShaderPainter(
              shader: shader!,
              time: time,
            ),
          ),
          Slider(
              max: 20,
              min: 0,
              value: time, onChanged: (v){
            setState(() {
              time = v;
            });
          }),
        ],
      );
    }

    return CustomPaint(
      size: const Size(300, 300),
      painter: ShaderPainter(
        shader: shader!,
      ),
    );
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
