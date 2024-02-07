import 'package:flutter/material.dart';

import 'color_coo_page.dart';
import 'image2_shader_demo.dart';
import 'image_shader_demo.dart';
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
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        fontFamily: '宋体'
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
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Shader 测试案例'),
          bottom: const TabBar(tabs: [
            Tab(text: '颜色+坐标',),
            Tab(text: '变量',),
            Tab(text: '贴图',),
            Tab(text: '特效',),
            // Tab(text: '马赛克',),
          ],
          ),
        ),
        body: const TabBarView(
          children: [
            ColorShaderDemo(),
            RectMaskShaderDemo(),
            ImageShaderDemo(),
            Image2ShaderDemo(),
          ],
        ),
      ),
    );
  }
}


