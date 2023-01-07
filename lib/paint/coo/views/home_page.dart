import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skeleton/app/global/toly_icon.dart';

import '../models/axis_range.dart';
import '../models/fun.dart';
import '../models/point_values.dart';
import '../painter/coordinate.dart';
import '../painter/function_manager.dart';
import '../painter/painter_box.dart';
import 'move_ctrl_button.dart';
import 'scale_ctrl_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PointValues pointValues = PointValues();
  final FunctionManager fm = FunctionManager();

  final Coordinate coordinate = Coordinate(
      xStep: 1,
      yStep: 1,
      range: const AxisRange(
        minX: -7.8,
        maxX: 7.8,
        minY: -7.8,
        maxY: 7.8,
      ));

  @override
  void initState() {
    super.initState();
    fm.add(Fun(fx: (x) => 5 * sin(x), color: Colors.blue, strokeWidth: 2));
    fm.add(Fun(fx: (x) => x, color: Colors.red, strokeWidth: 2));
    fm.add(Fun(fx: (x) => x * x * x / 20, color: Colors.purple, strokeWidth: 2));
    fm.add(Fun(fx: (x) => x * x, color: Colors.yellow, strokeWidth: 2));
    fm.add(Fun(fx: (x) => 4.5, color: Colors.green, strokeWidth: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onPanUpdate: _onPanUpdate,
              onDoubleTap: _clear,
              child: RepaintBoundary(
                child: CustomPaint(
                  size: MediaQuery.of(context).size,
                  painter: PainterBox(
                    pointValues,
                    coordinate: coordinate,
                    fm: fm
                  ),
                ),
              ),
            ),
            // Container(
            //   height: 80,
            //   margin: const EdgeInsets.only(top: 30),
            //   // color: Colors.red,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       MoveCtrlButton(onTapCtrl: _onTapCtrl),
            //       ScaleCtrlButton(onTapCtrl: _onTapCtrl),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  void _clear() {
    pointValues.clear();
  }

  void _onTapCtrl(CtrlType type) {
    if (type == CtrlType.right) {
      coordinate.move(const Offset(0.1, 0));
    }
    if (type == CtrlType.left) {
      coordinate.move(const Offset(-0.1, 0));
    }
    if (type == CtrlType.up) {
      coordinate.move(const Offset(0, 0.1));
    }
    if (type == CtrlType.down) {
      coordinate.move(const Offset(0, -0.1));
    }
    if (type == CtrlType.center) {
      coordinate.range = const AxisRange(
        minX: -10,
        maxX: 10,
        minY: -10,
        maxY: 10,
      );
    }
    if (type == CtrlType.bigger) {
      coordinate.scale(2);
    }
    if (type == CtrlType.smaller) {
      coordinate.scale(0.5);
    }
    print(type);
    pointValues.repaint();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double rate = coordinate.range.xSpan / 2 * 0.002;
    coordinate.move(details.delta.scale(-rate, rate));
    pointValues.repaint();
  }
}
