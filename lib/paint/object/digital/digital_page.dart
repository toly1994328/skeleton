
import 'package:flutter/material.dart';
import 'digital_path.dart';
import 'digital_widget.dart';

class DigitalPage extends StatefulWidget {
  const DigitalPage({Key? key}) : super(key: key);

  @override
  State<DigitalPage> createState() => _DigitalPageState();
}

class _DigitalPageState extends State<DigitalPage> {
  int _count = 0;

  final DigitalPath digitalPath = DigitalPath();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            _count++;
            setState(() {});

          },
        ),
        body: Center(
            child:
            // SingleDigitalWidget(
            //   color: Colors.black,
            //   width: 104,
            //   value: 8,
            // )
        //
            MultiDigitalWidget(
              colors: [Colors.red,Colors.orange,Colors.yellow,Colors.green,Colors.blue,Colors.indigo,Colors.purple,Colors.black],
          width: 76,
          spacing: 16,
          count: 8,
          value: _count,
        )

            // Wrap(
            //   spacing: 26,
            //   children: [
            //     // DigitalWidget(
            //     //   width: 124,
            //     //   value: 8,
            //     //   color: Colors.blue,
            //     //   digitalPath: digitalPath,
            //     // ),
            //     SingleDigitalWidget(
            //       width: 54,
            //       value: tenBit,
            //       digitalPath: digitalPath,
            //     ),
            //     SingleDigitalWidget(
            //       color: Colors.red,
            //       width: 54,
            //       value: oneBit,
            //       digitalPath: digitalPath,
            //     ),
            //   ],
            // ),
            ),
      ),
    );
  }
}
