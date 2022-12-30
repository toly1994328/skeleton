import 'package:flutter/material.dart';
import 'package:skeleton/paint/coo/point_values.dart';
import 'package:window_manager/window_manager.dart';

import 'painter_box.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(400, 500),
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

class _MyHomePageState extends State<MyHomePage> {

  final PointValues pointValues = PointValues();

  @override
  Widget build(BuildContext context) {
    print("=====_MyHomePageState#build===============");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _pushPoint,
      ),
      body: Center(
        child: GestureDetector(
          onDoubleTap: _clear,
          child: RepaintBoundary(
            child: CustomPaint(
              size: const Size(300,300),
              painter: PainterBox(
                  pointValues
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _pushPoint() {
    Offset newPoint = Offset.zero;
    if(pointValues.data.isNotEmpty){
      newPoint = pointValues.data.last.translate(0.1, 0.1);
    }
    pointValues.add(newPoint);
  }

  void _clear() {
    pointValues.clear();
  }
}
