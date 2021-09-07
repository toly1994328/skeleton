import 'dart:math';

import 'package:flutter/material.dart';

import 'angle_panter.dart';
import 'line.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Line line = Line(start: Offset(20, 20), end: const Offset(50, 80));

  late AnimationController ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(_updateLine);
  }

  @override
  void dispose() {
    line.dispose();
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // line.start = Offset.zero;
    // line.end = Offset(40, 0);
    // line.rotate(2.4085543677521746);

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            // line.record();
            ctrl.forward(from: 0);
          },
          child: CustomPaint(
            painter: AnglePainter(line: line
                // linker: linker
                ),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              height: 200,
              width: 200,
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _updateLine() {
    // print("${ctrl.value * 2 * pi}");
    Offset center = line.percent(0.2);
    line.rotate(ctrl.value * 2 * pi, centre: center);
    // line.rotate(ctrl.value * 2* pi);
  }
}
