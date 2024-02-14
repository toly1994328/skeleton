import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<Color> colors;
  final ValueChanged<Color> onSelected;
  final Color active;

  const ColorSelector({super.key, required this.colors, required this.active, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: colors.map((e) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: ()=>onSelected(e),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: e,
              borderRadius: BorderRadius.circular(4)
            ),
            child: active==e?Container(margin: EdgeInsets.all(6),color: Colors.white ,):null
          ),
        ),
      )).toList(),
    );
  }
}
