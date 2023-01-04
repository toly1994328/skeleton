import 'package:flutter/material.dart';
import 'package:skeleton/paint/coo/point_values.dart';
import 'package:window_manager/window_manager.dart';

import '../../components/drop_selectable_widget.dart';
import 'painter_box.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(500, 550),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final PointValues pointValues = PointValues();

  late AnimationController _ctrl;
  late Animation<double> animation;

  Map<String, Curve> maps = {
    'bounceOut': Curves.bounceOut,
    'linear': Curves.linear,
    'decelerate': Curves.decelerate,
    'fastLinearToSlowEaseIn': Curves.fastLinearToSlowEaseIn,
    'ease': Curves.ease,
    'easeIn': Curves.easeIn,
    'easeInToLinear': Curves.easeInToLinear,
    'easeInSine': Curves.easeInSine,
    'easeInQuad': Curves.easeInQuad,
    'easeInCubic': Curves.easeInCubic,
    'easeInQuart': Curves.easeInQuart,
    'easeInQuint': Curves.easeInQuint,
    'easeInExpo': Curves.easeInExpo,
    'easeInCirc': Curves.easeInCirc,
    'easeInBack': Curves.easeInBack,
    'easeOut': Curves.easeOut,
    'linearToEaseOut': Curves.linearToEaseOut,
    'easeOutSine': Curves.easeOutSine,
    'easeOutQuad': Curves.easeOutQuad,
    'easeOutCubic': Curves.easeOutCubic,
    'easeOutQuart': Curves.easeOutQuart,
    'easeOutQuint': Curves.easeOutQuint,
    'easeOutExpo': Curves.easeOutExpo,
    'easeOutCirc': Curves.easeOutCirc,
    'easeOutBack': Curves.easeOutBack,
    'easeInOut': Curves.easeInOut,
    'easeInOutSine': Curves.easeInOutSine,
    'easeInOutQuad': Curves.easeInOutQuad,
    'easeInOutCubic': Curves.easeInOutCubic,
    'easeInOutQuart': Curves.easeInOutQuart,
    'easeInOutExpo': Curves.easeInOutExpo,
    'easeInOutQuint': Curves.easeInOutQuint,
    'easeInOutCirc': Curves.easeInOutCirc,
    'easeInOutBack': Curves.easeInOutBack,
    'fastOutSlowIn': Curves.fastOutSlowIn,
    'slowMiddle': Curves.slowMiddle,
    'bounceIn': Curves.bounceIn,
    'bounceInOut': Curves.bounceInOut,
    'elasticIn': Curves.elasticIn,
    'elasticOut': Curves.elasticOut,
    'elasticInOut': Curves.elasticInOut,
  };

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(parent: _ctrl, curve: Curves.ease);
    _ctrl.addListener(_pushPoint);
  }

  @override
  Widget build(BuildContext context) {
    print("=====_MyHomePageState#build===============");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _startAnimation,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 30,
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(bottom: 20,right: 20),
              // color: Colors.red,
              child: DropSelectableWidget(
                fontSize: 12,
                data: maps.keys.toList(),
                iconSize: 20,
                height: 25,
                width: 180,
                disableColor: const Color(0xff1F425F),
                onDropSelected: (int index) async {
                  animation = CurvedAnimation(
                    parent: _ctrl,
                    curve: maps.values.toList()[index],
                  );
                  _startAnimation();
                },
              ),
            ),
            GestureDetector(
              onDoubleTap: _clear,
              child: RepaintBoundary(
                child: CustomPaint(
                  size: const Size(300, 300),
                  painter: PainterBox(pointValues),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _shouldCollect = false;

  void _pushPoint() {
    if (animation.value == 0 && !_shouldCollect) {
      _shouldCollect = true;
      return;
    }
    int count = pointValues.data.length;
    Offset newPoint = Offset(count / 60, animation.value);
    pointValues.add(newPoint);
  }

  void _clear() {
    pointValues.clear();
  }

  void _startAnimation() {
    _clear();
    _shouldCollect = false;
    _ctrl.forward(from: 0);
  }
}
