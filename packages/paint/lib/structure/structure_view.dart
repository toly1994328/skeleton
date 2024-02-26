import 'package:components/components.dart';
import 'package:components/toly_ui/button/hover_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paint/structure/array_painter.dart';

import '../components/coordinate.dart';
import 'draft_paper.dart';
import 'stack_painter.dart';

class StructureView extends StatefulWidget {
  const StructureView({super.key});

  @override
  State<StructureView> createState() => _StructureViewState();
}

class _StructureViewState extends State<StructureView> {
  bool _activeGrid = true;
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          activeIndex = (activeIndex+1)%8;
        });
      },
      child: Material(
        color: Colors.white,
        child: Stack(fit: StackFit.expand, children: [
          if(_activeGrid)
            GridBackGround(),
          DraftPaper(),
          // CustomPaint(
          //   painter: StackPainter(activeGrid: _activeGrid,arrayNode: ArrayNode<int>(
          //     name: 'list',
          //     array: [1,9,9,4,0,3],
          //     activeIndex: activeIndex,
          //     activeIndexName: 'index'
          //   )),
          // ),

          Positioned(
            top: 10,
            right: 10,
            child: ActiveIconButton(
              padding: const EdgeInsets.all(4),
              size: 16,
              icon: Icons.grid_4x4,
              onPressed: _toggleGrid,
              active: _activeGrid,
              activeColor: Colors.blue.withOpacity(0.6),
              defaultColor: Colors.white,
              inactiveColor: Colors.grey.withOpacity(0.6),
              hoverColor: Colors.white.withOpacity(0.6),
            ),
          )
        ]),
      ),
    );
  }

  void _toggleGrid() {
    setState(() {
      _activeGrid = !_activeGrid;
    });
  }
}

class GridBackGround extends StatelessWidget {
  const GridBackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: GridPainter(),);
  }
}

class GridPainter extends CustomPainter{

  final Coordinate coordinate = Coordinate(step: 20);


  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}