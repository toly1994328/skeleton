import 'package:flutter/material.dart';

import 'geometry_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  ValueNotifier<Config> config = ValueNotifier<Config>(
    Config(len: 60, angle: 45, percent: 0.5),
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(
              painter: GeometryPainter(
                config: config,
              ),
              child: Container(
                color: Colors.grey.withOpacity(0.1),
                height: 200,
                width: 200,
              ),
            ),
            // _buildSlider()
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildSlider() {
    return ValueListenableBuilder<Config>(
      valueListenable: config,
      builder: (_, Config value, __) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Slider(
                    min: 0,
                    max: 100,
                    value: value.len,
                    onChanged: (v) {
                      config.value = config.value.copyWith(len: v);
                    }),
                Text('长度 : ${value.len.toStringAsFixed(2)}'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Slider(
                    min: 0,
                    max: 360,
                    divisions: 360,
                    value: value.angle,
                    onChanged: (v) {
                      config.value = config.value.copyWith(angle: v);
                    }),
                Text('角度 : ${value.angle.toStringAsFixed(2)}°'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Slider(
                    min: 0,
                    max: 1,
                    // divisions: 360,
                    value: value.percent,
                    onChanged: (v) {
                      config.value = config.value.copyWith(percent: v);
                    }),
                Text('分度 : ${value.percent.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
