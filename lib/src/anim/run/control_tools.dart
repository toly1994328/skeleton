import 'package:flutter/material.dart';

class ControlTools extends StatelessWidget {
  final VoidCallback onReset;
  final VoidCallback onRotate;
  final VoidCallback onMove;

  const ControlTools({
    Key? key,
    required this.onReset,
    required this.onRotate,
    required this.onMove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: onReset,
            child: const Icon(Icons.refresh, color: Colors.blue,),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: onRotate,
            child: const Icon(Icons.rotate_90_degrees_ccw, color: Colors.blue),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: onMove,
            child: const Icon(Icons.run_circle_outlined, color: Colors.blue),
          )
        ],
      ),
    );
  }
}
