import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActiveIconButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final bool active;
  final Color? activeColor;
  final Color? inactiveColor;
  final double size;
  final Color? hoverColor;
  final Color? defaultColor;
  final EdgeInsetsGeometry? padding;
  final MouseCursor cursor;

  const ActiveIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.hoverColor,
    this.padding,
    this.size = 24,
    this.defaultColor,
    this.cursor = SystemMouseCursors.click,
    required this.active,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  State<ActiveIconButton> createState() => _ActiveIconButtonState();
}

class _ActiveIconButtonState extends State<ActiveIconButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    Color? color = (_hover) ? widget.hoverColor ?? Theme.of(context).primaryColor : widget.defaultColor;

    return MouseRegion(
      cursor: widget.cursor,
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
                color:
                    widget.active ? widget.activeColor : widget.inactiveColor,
                borderRadius: BorderRadius.circular(4)),
            child: Icon(
              widget.icon,
              size: widget.size,
              color: color,
            )),
      ),
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
