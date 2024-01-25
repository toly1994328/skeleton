import 'package:flutter/material.dart';

import 'toly_pop_menu.dart';

class PopPanel<T> extends StatefulWidget {
  final Widget child;
  final Size size;
  final Offset offset;

  /// Builds the context menu.
  final Widget panel;

  const PopPanel({
    super.key,
    required this.child,
    required this.panel,
    this.offset = Offset.zero,
    this.size = const Size(250, 0),
  });

  @override
  State<PopPanel> createState() => _PopPanelState();
}

class _PopPanelState<T> extends State<PopPanel<T>> {
  final ContextMenuController _contextMenuController = ContextMenuController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: widget.child,
    );
  }

  void _show() {
    TolyPopupMenuEntry<T> item = CustomTolyMenuItem(
      widget.panel,
      size: widget.size,
    );

    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final Offset offset = Offset(button.size.width / 2, button.size.height)+widget.offset;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero) + offset,
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    showTolyMenu<T?>(
      elevation: 0,
      color: Colors.transparent,
      context: context,
      items: [item],
      position: position,
    ).then<void>((T? newValue) {
      if (!mounted) {
        return null;
      }
      if (newValue == null) {
        // widget.onCanceled?.call();
        return null;
      }
      // widget.onSelected?.call(newValue);
    });
  }

  void _onTap() {
    _show();
  }
}

class CustomTolyMenuItem<T> extends TolyPopupMenuEntry<T> {
  final Size size;
  final Widget content;

  const CustomTolyMenuItem(this.content, {super.key, required this.size});

  @override
  State<StatefulWidget> createState() => _CustomTolyMenuItemState();

  @override
  // TODO: implement height
  double get height => kMinInteractiveDimension;

  @override
  bool represents(value) => true;
}

class _CustomTolyMenuItemState<T> extends State<CustomTolyMenuItem> {

  @override
  void didUpdateWidget(covariant CustomTolyMenuItem oldWidget) {
    print('============_CustomTolyMenuItemState#didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6)
          ]),
      // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: widget.content,
      // color: Colors.lightBlueAccent,
    );
  }
}
