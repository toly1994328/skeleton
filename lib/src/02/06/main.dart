import 'package:flutter/material.dart';

import 'geometry_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
  ValueNotifier<Config> config = ValueNotifier<Config>(
    Config(len: 60, angle: 45, percent: 0.5),
  );

  late AnimationController _ctrl;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300)
    );
    animation = CurvedAnimation(parent: _ctrl, curve: Curves.ease);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(
              painter: GeometryPainter(
                progress: animation,
              ),
              child: Container(
                color: Colors.grey.withOpacity(0.1),
                height: 200,
                width: 200,
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              if(_ctrl.isCompleted){
                _ctrl.reverse();

              }else{
                _ctrl.forward();

              }
            }, child: Text('切换'))
            // _buildSlider()
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildSlider() {
    return ValueListenableBuilder<Config>(
      valueListenable: config,
      builder: (_, Config value, __) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
          Expanded(
            child: Column(
              children: [
                Slider(
                    min: 0,
                    max: 100,
                    value: value.len,
                    onChanged: (v) {
                      config.value = config.value.copyWith(len: v);
                    }),
                Text('长度 : ${value.len.toStringAsFixed(2)}'),
              ],
            ),
          ),
          Spacer()
          // Expanded(
          //   child: Column(
          //     children: [
          //       Slider(
          //           min: 0,
          //           max: 1,
          //           // divisions: 360,
          //           value: value.percent,
          //           onChanged: (v) {
          //             config.value = config.value.copyWith(percent: v);
          //           }),
          //       Text('分度 : ${value.percent.toStringAsFixed(2)}'),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
