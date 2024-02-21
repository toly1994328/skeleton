import 'package:flutter/material.dart';

import 'color_coo_page.dart';
import 'effect_demo/effect_page.dart';
import 'fancy_demo/fany_page.dart';
import 'image2_shader_demo.dart';
import 'image_shader_demo.dart';
import 'rect_mask_shader_demo.dart';
import 'simple_demo/simple_demo_page.dart';
import 'var_demos/var_page.dart';

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
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Shader 测试案例'),
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
            Tab(text: '颜色坐标',),
            Tab(text: '变量传参',),
            Tab(text: '图形区域',),
            Tab(text: '贴图特效',),
            Tab(text: '炫彩创意',),
          ],
          ),
        ),
        body: const TabBarView(
          children: [

            ColorShaderDemo(),
            VarPage(),
            SimpleDemoPage(),

            EffectPage(),
            // RectMaskShaderDemo(),
            // ImageShaderDemo(),
            // Image2ShaderDemo(),

            FancyPage(),

          ],
        ),
      ),
    );
  }
}


