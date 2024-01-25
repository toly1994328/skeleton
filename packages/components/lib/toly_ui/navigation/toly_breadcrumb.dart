import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';

class TolyBreadcrumb extends StatelessWidget {
  final List<BreadcrumbItem> items;
  final double fontSize;
  final ValueChanged<BreadcrumbItem>? onTapItem;

  const TolyBreadcrumb({super.key, required this.items,  this.onTapItem, this.fontSize=14});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (int i = 0; i < items.length; i++) {
      children.add(TolyBreadcrumbItem(
        fontSize: fontSize,
        item: items[i], onTapItem: onTapItem,
      ));
      if (i != items.length - 1) {
        children.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            '/',
            style: TextStyle(color: Colors.grey),
          ),
        ));
      }
    }

    return Wrap(
      children: children,
    );
  }
}

class TolyBreadcrumbItem extends StatefulWidget {
  final BreadcrumbItem item;
  final double fontSize;

  final ValueChanged<BreadcrumbItem>? onTapItem;
  const TolyBreadcrumbItem({super.key, required this.item, required this.onTapItem, required this.fontSize});

  @override
  State<TolyBreadcrumbItem> createState() => _TolyBreadcrumbItemState();
}

class _TolyBreadcrumbItemState extends State<TolyBreadcrumbItem> {

  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    bool hasTarget = (widget.item.to != null);
    Color? color = (_hover&&hasTarget)?Colors.blue:null;
    MouseCursor cursor = hasTarget?SystemMouseCursors.click:SystemMouseCursors.basic;

    if(widget.item.active) {
      color = null;
      cursor = SystemMouseCursors.basic;
    }

    TextStyle style = TextStyle(
      fontSize: widget.fontSize,
      fontWeight: hasTarget ? FontWeight.bold : null,
      color: color
    );

    return MouseRegion(
      cursor: cursor,
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
          onTap: () {
            if(!widget.item.active){
              widget.onTapItem?.call(widget.item);
            }
          },
          child: Text(widget.item.label, style: style)),
    );
  }

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _hover = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _hover = false;
    });
  }
}

class BreadcrumbItem {
  final String? to;
  final String label;
  final bool active;

  BreadcrumbItem( {this.to, required this.label,this.active=false,});
}
