import 'package:flutter/material.dart';

/// A builder that includes an Offset to draw the context menu at.
typedef ContextMenuBuilder = Widget Function(BuildContext context, Offset offset);


class Popover extends StatefulWidget {
  final Widget child;
  /// Builds the context menu.
  final ContextMenuBuilder contextMenuBuilder;

  const Popover({
    super.key,
    required this.child,
    required this.contextMenuBuilder,
  });

  @override
  State<Popover> createState() => _PopoverState();
}

class _PopoverState extends State<Popover> {

  final ContextMenuController _contextMenuController = ContextMenuController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: widget.child,
    );
  }

  void _show(Offset position) {
    _contextMenuController.show(
      context: context,
      contextMenuBuilder: (BuildContext context) {
        return widget.contextMenuBuilder(context, position);
      },
    );
  }

  final double width = 200;

  void _onTap() {
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final Offset offset = Offset(button.size.width / 2, button.size.height);
    Offset boxOffset = button.localToGlobal(offset, ancestor: overlay);
    _show(boxOffset.translate(-width, 0));
  }
}
