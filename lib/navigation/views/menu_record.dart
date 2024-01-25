import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';

import '../menus/menu_scope/menu_history.dart';
import '../menus/menu_scope/menu_scope.dart';

class MenuRecord extends StatelessWidget {
  const MenuRecord({super.key});

  @override
  Widget build(BuildContext context) {
    MenuStore store = MenuScope.of(context);
    List<MenuHistory> history = MenuScope.of(context).history;
    const BorderSide side = BorderSide(color: Color(0xffE8E8E8), width: 1);
    Color themeColor = Theme.of(context).primaryColor;
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: const Color(0xffF2F2F2),
          border: Border(top: side, bottom: side)),
      height: 28,
      child: ListView(
        scrollDirection: Axis.horizontal,
          children: history
              .map((e) => RecordTab(
            canClose: history.length > 1,
            onCloseHistory: store.closeHistory,
            onTapHistory: store.selectHistory,
                    active: store.state.activeMenu == e.menuPath,
                    history: e,
                  ))
              .toList()),
    );
  }
}

class RecordTab extends StatelessWidget {
  final bool active;
  final bool canClose;
  final MenuHistory history;
  final ValueChanged<MenuHistory> onCloseHistory;
  final ValueChanged<String> onTapHistory;
  const RecordTab({
    super.key,
    this.active = false,
    required this.canClose,
    required this.history,
    required this.onCloseHistory,
    required this.onTapHistory,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: ()=>onTapHistory(history.menuPath),
      child: ColoredBox(
        color: active ? Colors.white : Colors.transparent,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  history.menuLabel,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                if(canClose)
                CloseHoverButton(
                  onPressed: ()=>onCloseHistory(history)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CloseHoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  const CloseHoverButton({super.key, required this.onPressed});

  @override
  State<CloseHoverButton> createState() => _CloseHoverButtonState();
}

class _CloseHoverButtonState extends State<CloseHoverButton> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onExit: _onExit,
        onEnter: _onEnter,
        child: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: _isHover ? Color(0xffBFC5C8) : Colors.transparent,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              CupertinoIcons.clear_thick,
              size: 10,
              color: _isHover ? Colors.white : Colors.grey,
            )),
      ),
    );
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _isHover = false;
    });
  }

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _isHover = true;
    });
  }
}
