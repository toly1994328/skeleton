import 'dart:typed_data';
import 'dart:ui';
import 'package:components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import '../components/switch_tabs.dart';
import 'e2_painter.dart';

class EffectPage extends StatefulWidget {
  const EffectPage({super.key});

  @override
  State<EffectPage> createState() => _EffectPageState();
}

class _EffectPageState extends State<EffectPage> {
  FragmentShader? shader;

  List<Map<String, String>> data = [
    {
      'file': 'shaders/eff_01_mask_rect.frag',
      'title': '马赛克',
    },
    {
      'file': 'shaders/fancy_02_length.frag',
      'title': '色彩效果',
    },
    {
      'file': 'shaders/fancy_03.frag',
      'title': '常见特效',
    },
    {
      'file': 'shaders/fancy_04.frag',
      'title': '复杂特效',
    },
    // {
    //   'file': 'shaders/fancy_05.frag',
    //   'title': '波浪线',
    // },
  ];

  String _activeTab = 'shaders/eff_01_mask_rect.frag';
  ui.Image? image;

  @override
  void initState() {
    super.initState();
    _loadShader(_activeTab);
    loadImage();

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

  @override
  Widget build(BuildContext context) {
    if (shader == null||image==null) {
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
      size: const Size(1280 * 0.2, 1706 * 0.2),
      painter: ShaderPainter(
        shader: shader!,
        image: image!
      ),
    );
  }
  @override
  void reassemble() {
    super.reassemble();
    _loadShader(_activeTab);
  }
}

class ShaderPainter extends CustomPainter {
  ShaderPainter({required this.shader,required this.image});

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
