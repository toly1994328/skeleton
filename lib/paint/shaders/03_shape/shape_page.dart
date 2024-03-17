import 'dart:ui';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skeleton/paint/shaders/03_shape/line_demo_panel.dart';
import 'package:skeleton/paint/shaders/custom_shader/size_image_shader_painter.dart';
import 'dart:ui' as ui;
import '../components/page_shower.dart';
import '../components/switch_tabs.dart';
import '../custom_shader/custom_shader_painter.dart';
import '../custom_shader/size_shader_painter.dart';
import 'config.dart';
import 'rect_demo_panel.dart';
import 'smooth_demo_panel.dart';

class ShapeDemoPage extends StatefulWidget {
  const ShapeDemoPage({super.key});

  @override
  State<ShapeDemoPage> createState() => _ShapeDemoPageState();
}

class _ShapeDemoPageState extends State<ShapeDemoPage> {
  FragmentShader? shader;

  ShapeTab _activeTab = ShapeTab.circle;
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
    Map<String, dynamic> map =
        data.where((e) => e['file'] == _activeTab.id).first;
    if (map['step'] == null) return _activeTab.id;
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
            activeTab: _activeTab.id,
            onTabChanged: _onChangeShader,
          ),
        ),
        const SizedBox(height: 20),
        Center(child: _buildByTab(_activeTab)),
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
    print("=====${path}=======");
    shader = program.fragmentShader();
    setState(() {});
  }

  void _onChangeShader(String value) {
    setState(() {
      _currentStep = 0;
      progress = 0.2;
      _activeTab = ShapeTab.values.singleWhere((s) => s.id == value);
    });
    _loadShader(shaderPath);
  }

  double time = 0;
  double progress = 0.01;

  Widget _buildByTab(ShapeTab tab) => switch (tab) {
        ShapeTab.circle => PageShower(
            activePage: _currentStep,
            prev: prev,
            next: next,
            maxPage: maxPage,
            child: CustomPaint(
              size: const Size(300, 300),
              painter: CustomShaderPainter(
                shader: shader!,
                image: [5, 6].contains(_currentStep) ? image! : null,
              ),
            ),
          ),
        ShapeTab.smooth => SmoothDemoPanel(
            activePage: _currentStep,
            maxPage: maxPage,
            prev: prev,
            next: next,
            image: image!,
            progress: progress,
            shader: shader!,
            onProgressChange: _onProgressChange,
          ),
        ShapeTab.line => LineDemoPanel(
            activePage: _currentStep,
            maxPage: maxPage,
            prev: prev,
            next: next,
            progress: progress,
            shader: shader!,
            onProgressChange: _onProgressChange,
            image: image!,
          ),
        ShapeTab.rect => RectDemoPanel(
            activePage: _currentStep,
            maxPage: maxPage,
            prev: prev,
            next: next,
            progress: progress,
            shader: shader!,
            onProgressChange: _onProgressChange,
            image: image!,
          ),
      };

  @override
  void reassemble() {
    super.reassemble();
    _loadShader(shaderPath);
  }

  void _onProgressChange(double value) {
    setState(() {
      progress = value;
    });
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
