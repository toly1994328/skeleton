import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'scan/animation_scanner.dart';
import 'shadow/shadow_painter_v1.dart';
import 'shadow/shadow_painter_v2.dart';
import 'snow/snow_painter.dart';
import 'snow/snow_painter1.dart';

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
      home: const AnimationScannerView(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Flutter 路径阴影绘制"),),
      body: Center(
        child: CustomPaint(
          size: const Size(300,300),
          // painter: ShadowPainterV1(),
          painter: ShadowPainterV2(),
          // painter: SnowPainter1(),
        ),
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Wrap(
//           children: List.generate(45, (index) => RepaintBoundary(
//             child: CustomPaint(
//               size: Size(100,100),
//               painter: SnowPainter(),
//               // painter: SnowPainter1(),
//             ),
//           ),
//           )),
//       ),
//     );
//   }
// }


