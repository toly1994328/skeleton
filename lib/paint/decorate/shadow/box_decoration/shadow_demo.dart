import 'package:flutter/material.dart';

void main() => runApp(const ExampleApp());


class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Wrap(
              direction: Axis.vertical,
              spacing: 40,
              children: const [
                ShadowElement(),
                ShadowAnt(),
                ShadowIView(),
              ],
            ),
          )),
    );
  }
}

class ShadowElement extends StatelessWidget {
  const ShadowElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ElementUI 阴影
    BoxDecoration element = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color:const Color(0xffebeef5)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0,2),
          blurRadius: 12,
          spreadRadius: 0,
        )
      ],
    );

    return DecoratedBox(decoration: element ,child:Padding(
      padding: const EdgeInsets.all(14.0),
      child: SizedBox(
        width: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text('提示',style: TextStyle(fontWeight: FontWeight.bold),),
                Spacer(),
                Icon(Icons.close,size: 16,color: Color(0xff909399),)
              ],
            ),
            const SizedBox(height: 5,),
            const Text('这是 Element UI 中弹框的阴影效果'),
          ],
        ),
      ),
    ),);
  }
}


class ShadowAnt extends StatelessWidget {
  const ShadowAnt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ant Design 阴影
    BoxDecoration decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: const Offset(0,6),
          blurRadius: 16,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          offset: const Offset(0,3),
          blurRadius: 6,
          spreadRadius: -4,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          offset: const Offset(0,9),
          blurRadius: 28,
          spreadRadius: 8,
        )
      ],
    );
    return DecoratedBox(decoration: decoration ,child:Padding(
      padding: const EdgeInsets.all(14.0),
      child: SizedBox(
        width: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text('提示',style: TextStyle(fontWeight: FontWeight.bold),),
                Spacer(),
                Icon(Icons.close,size: 16,color: Color(0xff909399),)
              ],
            ),
            const SizedBox(height: 5,),
            const Text('这是 Ant Design 中弹框的阴影效果'),
          ],
        ),
      ),
    ),);
  }
}


class ShadowIView extends StatelessWidget {
  const ShadowIView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ant Design 阴影
    BoxDecoration decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: const Offset(0,1),
          blurRadius: 6,
          spreadRadius: 0,
        ),
      ],
    );
    return DecoratedBox(decoration: decoration ,child:Padding(
      padding: const EdgeInsets.all(14.0),
      child: SizedBox(
        width: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text('提示',style: TextStyle(fontWeight: FontWeight.bold),),
                Spacer(),
                Icon(Icons.close,size: 16,color: Color(0xff909399),)
              ],
            ),
            const SizedBox(height: 5,),
            const Text('这是 View Design 中弹框的阴影效果'),
          ],
        ),
      ),
    ),);
  }
}