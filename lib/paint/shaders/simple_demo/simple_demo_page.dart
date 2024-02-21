import 'dart:typed_data';
import 'dart:ui';
import 'package:components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;
import '../components/switch_tabs.dart';
import 'e2_painter.dart';

class SimpleDemoPage extends StatefulWidget {
  const SimpleDemoPage({super.key});

  @override
  State<SimpleDemoPage> createState() => _SimpleDemoPageState();
}

class _SimpleDemoPageState extends State<SimpleDemoPage> {
  FragmentShader? shader;

  List<Map<String, dynamic>> data = [
    {
      'file': 'shaders/base_01_circle_step1.frag',
      'title': '圆形',
      'step': [
        'shaders/base_01_circle_step1.frag',
        'shaders/base_01_circle_step2.frag',
        'shaders/base_01_circle_step3.frag',
        'shaders/base_01_circle_step4.frag',
        'shaders/base_01_circle_step5.frag',
        'shaders/base_01_circle_step6.frag',
        'shaders/base_01_circle_step7.frag',
      ]
    },
    {
      'file': 'shaders/base_02_polygon_step1.frag',
      'title': '多边形',
    },
    {
      'file': 'shaders/fancy_03.frag',
      'title': '变换',
    },
    {
      'file': 'shaders/fancy_04.frag',
      'title': '创意图形',
    },
    // {
    //   'file': 'shaders/fancy_05.frag',
    //   'title': '波浪线',
    // },
  ];

  String _activeTab = 'shaders/base_01_circle_step1.frag';
  int _currentStep = 0;
  int maxPage = 0;
  ui.Image? image;

  @override
  void initState() {
    super.initState();

    _loadShader(shaderPath);
    loadImage();
  }

  void loadImage() async {
    image = await loadImageFromAssets('assets/images/ac_rect.webp');
    setState(() {});
  }

  //读取 assets 中的图片
  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
  }

  String get shaderPath {
    Map<String, dynamic> map = data.where((e) => e['file'] == _activeTab).first;
    if (map['step'] == null) return _activeTab;
    maxPage = map['step'].length;
    String path = map['step'][_currentStep];
    return path;
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null || image == null) {
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
            'shader 文件: $shaderPath',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        Expanded(
            child: CodeView(
          path: 'assets/code/$shaderPath',
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
    _loadShader(shaderPath);
  }

  double time = 0;

  Widget _buildByTab() {
    if (_activeTab == 'shaders/eff_02_step1.frag' ||
        _activeTab == 'shaders/fancy_03.frag' ||
        _activeTab == 'shaders/fancy_04.frag' ||
        _activeTab == 'shaders/fancy_05.frag') {
      return Column(
        children: [
          CustomPaint(
            size: const Size(300, 300),
            painter: S2ShaderPainter(
              shader: shader!,
            ),
          ),
          Slider(
              max: 20,
              min: 0,
              value: time,
              onChanged: (v) {
                setState(() {
                  time = v;
                });
              }),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: _currentStep == 0 ? null : prev,
                  icon: Icon(Icons.navigate_before)),
              Expanded(
                child: Center(
                  child: _currentStep == 5 || _currentStep == 6
                      ? CustomPaint(
                          size: const Size(300, 300),
                          painter:
                              ShaderPainter(shader: shader!, image: image!),
                        )
                      : CustomPaint(
                          size: const Size(300, 300),
                          painter: S2ShaderPainter(shader: shader!),
                        ),
                ),
              ),
              IconButton(
                  onPressed: _currentStep == maxPage - 1 ? null : next,
                  icon: Icon(Icons.navigate_next_sharp)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Text(
              '${_currentStep + 1}/$maxPage',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    _loadShader(shaderPath);
  }

  void prev() {
    _currentStep--;
    _loadShader(shaderPath);
  }

  void next() {
    _currentStep++;
    _loadShader(shaderPath);
  }
}

class ShaderPainter extends CustomPainter {
  ShaderPainter({
    required this.shader,
    required this.image,
  });

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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
