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
      home: const GameBoxPage(),
    );
  }
}

class GameBoxPage extends StatefulWidget {
  const GameBoxPage({Key? key}) : super(key: key);

  @override
  State<GameBoxPage> createState() => _GameBoxPageState();
}

class _GameBoxPageState extends State<GameBoxPage> {
  int _count = 0;



  @override
  Widget build(BuildContext context) {
    return   Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
              builder: (ctx,cts)=> SizedBox(
                  width: (800/1752)*cts.maxHeight,
                  height: cts.maxHeight,
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
