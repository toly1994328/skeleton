import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmptyPanel extends StatelessWidget {
  final String msg;
  const EmptyPanel({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return  Material(
      child: Center(
        child: Wrap(
          spacing: 16,
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          children: [
            Icon(Icons.nearby_error,size: 64, color: Colors.redAccent),
            Text(
              msg,
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
            ElevatedButton(onPressed: (){
              context.go('/dashboard/view');
            }, child: Text('返回首页'))
          ],
        ),
      ),
    );
  }
}