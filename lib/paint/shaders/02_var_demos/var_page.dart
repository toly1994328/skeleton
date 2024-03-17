import 'dart:ui';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import '../components/color_selector.dart';
import '../components/switch_tabs.dart';
import 'v1_painter.dart';
import 'v2_painter.dart';
import 'v3_painter.dart';
import 'v4_painter.dart';

class VarPage extends StatefulWidget {
  const VarPage({super.key});

  @override
  State<VarPage> createState() => _VarPageState();
}

class _VarPageState extends State<VarPage> {
  FragmentShader? shader;
  ui.Image? image;

  List<Map<String, String>> data = [
    {
      'file': 'shaders/var_01.frag',
      'title': '尺寸入参',
    },
    {
      'file': 'shaders/var_02.frag',
      'title': '渐变颜色',
    },
    {
      'file': 'shaders/var_03.frag',
      'title': '纹理贴图',
    },
    {
      'file': 'shaders/var_04.frag',
      'title': '贴图混色',
    }
  ];

  void _loadImage() async {
    image = await loadImageFromAssets('assets/images/ac.webp');
    setState(() {});
  }

  //读取 assets 中的图片
  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
  }

  String _activeTab = 'shaders/var_01.frag';
  List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.indigo,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
  ];

  late Color activeColor = colors.first;
  double progress = 0.5;
  @override
  void initState() {
    super.initState();
    _loadShader(_activeTab);
    _loadImage();
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
        const SizedBox(height: 20),
        Center(child: _buildByTab(_activeTab)),
        if (_activeTab == 'shaders/var_02.frag'||_activeTab =='shaders/var_04.frag')
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8),
            child: ColorSelector(
              onSelected: (color) {
                setState(() {
                  activeColor = color;
                });
              },
              active: activeColor,
              colors: colors,
            ),
          ),
        if(_activeTab =='shaders/var_04.frag')
        Slider(value: progress, onChanged: (v){
          setState(() {
            progress = v;
          });
        }),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 10),
          child: Text(
            'shader 文件: $_activeTab',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        Expanded(child: CodeView(path: 'assets/code/$_activeTab')),
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

  Widget _buildByTab(String activeTab) {
    if (activeTab == 'shaders/var_02.frag') {
      return CustomPaint(
        size: const Size(400, 200),
        painter: V2ShaderPainter(shader: shader!, color: activeColor),
      );
    }
    if (activeTab == 'shaders/var_03.frag') {
      if (image == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return CustomPaint(
        size: const Size(1280 * 0.2, 1706 * 0.2),
        painter: V3ShaderPainter(shader: shader!, image: image!),
      );
    }
    if (activeTab == 'shaders/var_04.frag') {
      if (image == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return CustomPaint(
        size: const Size(1280 * 0.2, 1706 * 0.2),
        painter: V4ShaderPainter(shader: shader!, image: image!, color: activeColor,progress: progress),
      );
    }
    return CustomPaint(
      size: const Size(400, 200),
      painter: V1ShaderPainter(shader: shader!),
    );
  }
}








