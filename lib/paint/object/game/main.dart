import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'painter/ctrl_painter.dart';
import 'painter/outer_shell_painter.dart';

void main() async {
  if (Platform.isWindows || Platform.isMacOS) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(500, 1000),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _count = 0;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body:  Center(
          child: SizedBox(
              width: 800/2,
              height: 1752/2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CustomPaint(
                    painter: OuterShellPainter(),
                  ),
                  CustomPaint(
                    painter: CtrlPainter(),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
