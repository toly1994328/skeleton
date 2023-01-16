import 'package:flutter/material.dart';
import 'package:skeleton/paint/aeroplane/painter/board_painter.dart';
import 'package:skeleton/paint/aeroplane/painter/chess_painter.dart';

import 'model/chess_value.dart';

class PlayBoard extends StatefulWidget {
  const PlayBoard({Key? key}) : super(key: key);

  @override
  State<PlayBoard> createState() => _PlayBoardState();
}

class _PlayBoardState extends State<PlayBoard> {
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
