import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'angle_panter.dart';

import 'image_zone.dart';
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

  Line line = Line();

  late AnimationController ctrl;
  ui.Image? _image;
  ui.Image? _bgImage;

  void _loadImage() async {
    ByteData data = await rootBundle.load('assets/images/hand.png');
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    _image = await decodeImageFromList(Uint8List.fromList(bytes));
    line.attachImage(ImageZone(
        rect: const Rect.fromLTRB(0, 93, 104, 212),
        image: _image!,
    ));
  }

  void _loadImage2() async {
    ByteData bgData = await rootBundle.load('assets/images/body.png');
    List<int> bgBytes = bgData.buffer.asUint8List(bgData.offsetInBytes, bgData.lengthInBytes);
    _bgImage = await decodeImageFromList(Uint8List.fromList(bgBytes));
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(_updateLine);
    _loadImage();
    _loadImage2();
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
            ctrl.repeat(reverse: true);
          },
          child:
              CustomPaint(
                painter: AnglePainter(line: line,
                    // linker: linker
                    image:_bgImage),
                child: Container(
                  // color: Colors.grey.withOpacity(0.1),
                  // height: 200,
                  // width: 200,
                ),
              ),
          ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _updateLine() {
    // print("${ctrl.value * 2 * pi}");
    line.rotate(ctrl.value * 2* pi/50);
  }
}
