import 'package:flutter/material.dart';
import 'package:skeleton/src/chart/pie/01/model/sale_data.dart';

class LegendItem extends StatelessWidget {
  final SaleData data;
  final Color color;

  const LegendItem({Key? key,required this.data,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children:  [
         CircleAvatar(
          backgroundColor: color,
          radius: 6,
        ),
        const SizedBox(width: 6,),
        Text(data.name,),
      ],
    );
  }
}
