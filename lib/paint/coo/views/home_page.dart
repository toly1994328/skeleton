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

class CooPage extends StatefulWidget {
  const CooPage({Key? key}) : super(key: key);

  @override
  State<CooPage> createState() => _CooPageState();
}

class _CooPageState extends State<CooPage> {
  final PointValues pointValues = PointValues();
  final FunctionManager fm = FunctionManager();

  final Coordinate coordinate = Coordinate(
      xStep: 5,
      yStep: 5,
      range: const AxisRange(
        minX: 0,
        maxX: 7.8,
        minY: 0,
        maxY: 7.8,
      ));

  @override
  void initState() {
    super.initState();
    fm.add(Fun(fx: (x) => 6 * sin(0.5*x), color: Colors.blue, strokeWidth: 2));
    fm.add(Fun(fx: (x) => x, color: Colors.red, strokeWidth: 2));
    fm.add(
        Fun(fx: (x) => x * x * x / 20, color: Colors.purple, strokeWidth: 2));
    fm.add(Fun(fx: (x) => x * x, color: Colors.yellow, strokeWidth: 2));
    fm.add(Fun(fx: (x) => 4.5, color: Colors.green, strokeWidth: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onPanUpdate: _onPanUpdate,
            onDoubleTap: _clear,
            child: RepaintBoundary(
              child: CustomPaint(
                size: MediaQuery.of(context).size,
                painter:
                    PainterBox(pointValues, coordinate: coordinate, fm: fm),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 20,
            child: ScaleCtrlButton(onTapCtrl: _onTapCtrl),
          ),
        ],
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
      coordinate.scale(1.1);
    }
    if (type == CtrlType.smaller) {
      coordinate.scale(0.9);
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
