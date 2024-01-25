import 'package:flutter/material.dart';
import 'package:skeleton/paint/aeroplane/painter/board_painter.dart';
import 'package:skeleton/paint/aeroplane/painter/chess_painter.dart';

import 'model/chess_value.dart';

class AeroplaneBoard extends StatefulWidget {
  const AeroplaneBoard({Key? key}) : super(key: key);

  @override
  State<AeroplaneBoard> createState() => _AeroplaneBoardState();
}

class _AeroplaneBoardState extends State<AeroplaneBoard> {
  ChessValue chessValue = ChessValue();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            children: [
              RepaintBoundary(
                child: CustomPaint(
                  size: MediaQuery.of(context).size,
                  painter: BoardPainter(),
                ),
              ),
              CustomPaint(
                size: MediaQuery.of(context).size,
                painter: ChessPainter(chessValue),
              )
            ],
          ),
        ),
      ),
    );
  }
}
