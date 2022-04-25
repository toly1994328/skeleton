import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'drawable.dart';
import 'world.dart';

void main() {
  runApp(const World());
}

class World extends StatefulWidget {
  const World({Key? key}) : super(key: key);

  @override
  State<World> createState() => _WorldState();
}

class _WorldState extends State<World> with SingleTickerProviderStateMixin {
  late WorldRender render;

  late Ticker _ticker;

  void _tick(Duration elapsed) {
    render.updateBall();
  }

  @override
  void initState() {
    super.initState();
    var window = WidgetsBinding.instance!.window;
    // MediaQuery
    render = WorldRender();
    render.size = window.physicalSize / window.devicePixelRatio;
    _ticker = createTicker(_tick);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_ticker.isTicking) {
          _ticker.stop();
        } else {
          _ticker.start();
        }
      },
      child: CustomPaint(
        painter: render,
      ),
    );
  }
}
