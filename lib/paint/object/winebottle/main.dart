import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'winebottle_pianter.dart';

void main() async {
  if(Platform.isWindows||Platform.isMacOS){
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(600, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
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

class MyHomePage extends StatefulWidget{
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin{

  late AnimationController _ctrl ;
  List<double> bodies = [];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this,duration: const Duration(milliseconds: 1000));
    resetBody();
    _ctrl.forward();
  }

  //52 196
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: _startAnimation,
          child: CustomPaint(
            size: const Size(52*2,196*2),
            painter: WineBottlePainter(
              _ctrl,
              bodies: bodies
            ),
            // painter: SnowPainter1(),
          ),
        ),
      ),
    );
  }

  void _startAnimation() {
    resetBody();
    _ctrl.forward(from: 0);
  }

  final Random _random = Random();


  void resetBody(){
    bodies = [];
    int count = 2 + _random.nextInt(4);
    // 获取一个数字列表，
    // 其中元素个数 2~6 。
    // 且数字随记， 0.1 ~ 0.5
    // 且之和为 1
    double sum = 0;
    for(int i = 0; i<count;i++){
      double s = 0.1+_random.nextDouble()*0.4; // 0.1 ~ 0.5
      sum+=s;
      bodies.add(s);
    }
    double avgData = (sum -1)/bodies.length ;
    bodies = bodies.map((e) => e-avgData).toList();
    setState(() {

    });
  }
}



