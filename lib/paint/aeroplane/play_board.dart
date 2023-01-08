import 'package:flutter/material.dart';
import 'package:skeleton/paint/aeroplane/painter/board_painter.dart';

class PlayBoard extends StatelessWidget {
  const PlayBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: CustomPaint(
            size: MediaQuery.of(context).size,
            painter: BoardPainter(),
          ),
        ),
      ),
    );
  }
}
