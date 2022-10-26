import 'package:flutter/material.dart';

void main() {
  runApp(const ColoredBox(color: Colors.white, child: Painter()));
}

class Painter extends StatelessWidget {
  const Painter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      // painter: PortPathPainter(),
    );
  }
}