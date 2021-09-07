import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skeleton/src/linker.dart';
import 'package:skeleton/src/paper.dart';

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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  Linker linker = Linker(start: Offset.zero, end: Offset(60, 80));

  late AnimationController ctrl = AnimationController(
    vsync:  this,
    duration: Duration(seconds: 3)
  )..addListener(() {
    linker.updateNodeAnchor(0, ctrl.value);
  });

  @override
  void initState() {
    super.initState();
    linker.appendByLength(0.5, 40,120*pi/180);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
            ctrl.forward(from: 0);
          },
          child: CustomPaint(
            painter: SkeletonPaper(
              linker: linker
            ),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              height: 300,
              width: 300,
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


