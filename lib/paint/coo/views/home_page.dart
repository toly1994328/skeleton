import 'package:flutter/material.dart';
import 'package:skeleton/app/global/toly_icon.dart';

import '../models/coo_config.dart';
import '../models/point_values.dart';
import '../painter/coordinate.dart';
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

  final Coordinate coordinate = Coordinate(
      xScaleCount: 10,
      yScaleCount: 10,
      range: const AxisRange(
          minX: -1,
          maxX: 1,
          maxY: 1,
          minY: -1
      )
  );

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   coordinate.range = const AxisRange(
  //     minX: 32.5,
  //     maxX: 64.8,
  //     minY: 0.5,
  //     maxY: 10.5
  //   );
  //   pointValues.repaint();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onDoubleTap: _clear,
              child: RepaintBoundary(
                child: CustomPaint(
                  size: const Size(400, 400),
                  painter: PainterBox(pointValues,coordinate: coordinate),
                ),
              ),
            ),
            Container(
              height: 80,
              margin: const EdgeInsets.only(top: 30),
              // color: Colors.red,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MoveCtrlButton(onTapCtrl: _onTapCtrl),
                  ScaleCtrlButton(onTapCtrl: _onTapCtrl),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  void _clear() {
    pointValues.clear();
  }


  void _onTapCtrl(CtrlType type) {
    if(type == CtrlType.right){
      coordinate.move(const Offset(0.1, 0));
    }
    if(type == CtrlType.left){
      coordinate.move(const Offset(-0.1, 0));
    }
    if(type == CtrlType.up){
      coordinate.move(const Offset(0, 0.1));
    }
    if(type == CtrlType.down){
      coordinate.move(const Offset(0, -0.1));
    }
    if(type == CtrlType.center){
      coordinate.range = const AxisRange();
    }
    if(type == CtrlType.bigger){
      coordinate.scale(2);
    }
    if(type == CtrlType.smaller){
      coordinate.scale(0.5);
    }
    print(type);
    pointValues.repaint();

  }
}
