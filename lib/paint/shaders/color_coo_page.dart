import 'dart:ui';
import 'package:components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorShaderDemo extends StatefulWidget {
  const ColorShaderDemo({super.key});

  @override
  State<ColorShaderDemo> createState() => _ColorShaderDemoState();
}

class _ColorShaderDemoState extends State<ColorShaderDemo> {
  FragmentShader? shader;

  List<Map<String, String>> data = [
    {'file': 'shaders/color.frag', 'title': '纯颜色',},
    {'file': 'shaders/color1.frag', 'title': '二分色',},
    {'file': 'shaders/color2.frag', 'title': '四分色',},
    {'file': 'shaders/color3.frag', 'title': '渐变色',}
  ];

  String _activeTab = 'shaders/color.frag';

  @override
  void initState() {
    super.initState();
    _loadShader(_activeTab);
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null) {
      return const Center(child: CircularProgressIndicator(),);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Center(child: SwitchTabs(data: data, activeTab: _activeTab, onTabChanged: _onChangeShader,)),
      const SizedBox(height: 20,),
      Center(
        child: CustomPaint(
          size: const Size(400, 200), painter: ShaderPainter(shader: shader!,),),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16.0,top: 10),
        child: Text('shader 文件: $_activeTab',style: TextStyle(color: Colors.blue),),
      ),
        Expanded(child: CodeView(path: 'assets/code/$_activeTab',

        )),
        const SizedBox(height: 10,),
    ],);
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
}

class SwitchTabs extends StatelessWidget {
  final List<Map<String, String>> data;
  final String activeTab;
  final ValueChanged<String> onTabChanged;
  const SwitchTabs(
      {Key? key, required this.data, required this.activeTab, required this.onTabChanged,})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl<String>(groupValue: activeTab,
        onValueChanged: onTabChanged,
        padding: const EdgeInsets.only(top: 20),
        children: _buildMap(data)


    );
  }

  // void _onValueChanged(int value) {
  //   setState(() {
  //     _value = value;
  //   });
  // }

  Map<String, Widget> _buildMap(List<Map<String, String>> data) {
    Map<String, Widget> result = {};
    for (int i = 0; i < data.length; i++) {
      result [data[i]['file']!] = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(data[i]['title']!),
      );
    }
    return result;
  }
}

class ShaderPainter extends CustomPainter {
  ShaderPainter({required this.shader});

  FragmentShader shader;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = shader;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint,);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
