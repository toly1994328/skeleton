import 'package:flutter/material.dart';

import 'color_shader_demo.dart';
import 'image2_shader_demo.dart';
import 'image_shader_demo.dart';
import 'mask_shader_demo.dart';
import 'rect_mask_shader_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Shader Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        fontFamily: '黑体'
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Shader 测试案例'),
          bottom: const TabBar(tabs: [
            Tab(text: '颜色',),
            Tab(text: '贴图',),
            Tab(text: '黑白',),
            Tab(text: '矩形马赛克',),
            Tab(text: '圆形马赛克',),
          ],

          ),
        ),
        body: const TabBarView(
          children: [
            RectMaskShaderDemo(),

            ColorShaderDemo(),
            ImageShaderDemo(),
            Image2ShaderDemo(),
            MaskShaderDemo(),

          ],
        ),
      ),
    );
  }
}


