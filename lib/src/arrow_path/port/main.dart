import 'package:flutter/material.dart';
import 'package:skeleton/src/arrow_path/arrow/arrow_path.dart';

import '../arrow/port_path.dart';
import 'example.dart';

void main() {
  runApp(const ColoredBox(color: Colors.white, child: Painter()));
}

class Painter extends StatelessWidget {
  const Painter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ExamplePainter(),
    );
  }
}

