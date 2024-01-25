import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HoverIconButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final double size;
  final Color? hoverColor;
  final Color? defaultColor;
  final MouseCursor cursor;

  const HoverIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.hoverColor,
    this.size = 24,
    this.defaultColor,
    this.cursor = SystemMouseCursors.click,
  });

  @override
  State<HoverIconButton> createState() => _HoverIconButtonState();
}

class _HoverIconButtonState extends State<HoverIconButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    Color? color = (_hover)
        ? widget.hoverColor ?? Theme.of(context).primaryColor
        : (widget.defaultColor ?? null);

    return MouseRegion(
      cursor: widget.cursor,
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
          onTap: widget.onPressed,
          child: Icon(
            widget.icon,
            size: widget.size,
            color: color,
          )),
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
