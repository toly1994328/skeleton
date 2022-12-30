import 'package:flutter/material.dart';
import 'package:skeleton/paint/coo/point_values.dart';
import 'package:window_manager/window_manager.dart';

import 'painter_box.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
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

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(parent:_ctrl, curve: Curves.ease);
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
        child: GestureDetector(
          onDoubleTap: _clear,
          child: RepaintBoundary(
            child: CustomPaint(
              size: const Size(300, 300),
              painter: PainterBox(pointValues),
            ),
          ),
        ),
      ),
    );
  }

  bool shouldCollect = false;

  void _pushPoint() {

    if(animation.value==0&&!shouldCollect){
      shouldCollect = true;
      return;
    }

    int count = pointValues.data.length;
    print("====count==${count}==========_ctrl：${_ctrl.value}=========");

    Offset newPoint = Offset(count/60,animation.value);
    pointValues.add(newPoint);

  }

  void _clear() {
    pointValues.clear();
  }

  void _startAnimation() {
    _clear();
    shouldCollect = false;
    _ctrl.forward(from: 0);
  }
}
