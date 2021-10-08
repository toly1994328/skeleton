import 'package:flutter/material.dart';

import 'shape_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 15,
          children: [
            CustomPaint(
              painter: ShapePainter(3),
              size: const Size(200, 200),
            ),
            CustomPaint(
              painter: ShapePainter(5),
              size: const Size(200, 200),
            ),
            CustomPaint(
              painter: ShapePainter(9),
              size: const Size(200, 200),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _updateLine() {}
}
