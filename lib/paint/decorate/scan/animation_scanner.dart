import 'package:flutter/material.dart';

import 'scanner_painter.dart';

class AnimationScannerView extends StatefulWidget {
  const AnimationScannerView({Key? key}) : super(key: key);

  @override
  State<AnimationScannerView> createState() => _AnimationScannerViewState();
}

class _AnimationScannerViewState extends State<AnimationScannerView> with SingleTickerProviderStateMixin{

  late AnimationController _ctrl ;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this,duration: const Duration(milliseconds: 3000));
    animation = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    // _ctrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  GestureDetector(
        onTap: _startAnimation,
        child: CustomPaint(
          size: const Size(300,400),
          foregroundPainter: ScannerPainter(
              animation: animation
          ),
          child: Image.asset('assets/images/sabar.webp',width: 300,),
        ),
        )
      ),
    );
  }

  void _startAnimation() {
    _ctrl.repeat();
  }
}
