import 'dart:math';

import 'package:flutter/material.dart';
import 'shape_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

class MyHomePage extends StatelessWidget{
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
            painter: ShapePainter(
            ),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              height: 200,
              width: 200,
            ),
          ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
