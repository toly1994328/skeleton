import 'package:flutter/material.dart';

class TopLogo extends StatelessWidget {
  const TopLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
      child: Row(
        children: [
          FlutterLogo(),
          const SizedBox(width: 8,),
          Text(
            'Skeleton',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
          )
        ],
      ),
    );
  }
}
