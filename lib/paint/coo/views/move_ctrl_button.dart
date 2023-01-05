import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skeleton/app/global/toly_icon.dart';

enum CtrlType { left, right, up, down, center , smaller, bigger}

typedef CtrlTapCallback = void Function(CtrlType type);

class MoveCtrlButton extends StatelessWidget {

  final CtrlTapCallback onTapCtrl;

  const MoveCtrlButton({Key? key, required this.onTapCtrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                const Spacer(),
                Expanded(child: HoverActiveIcon(
                  icon: TolyIcon.arrow_up,
                  onTap: () => handleTap(CtrlType.up),
                ),),
                const Spacer(),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: HoverActiveIcon(
                  icon: TolyIcon.icon_left,
                  onTap: () => handleTap(CtrlType.left),
                ),),
                Expanded(child: HoverActiveIcon(
                  icon: TolyIcon.icon_reset,
                  onTap: () => handleTap(CtrlType.center),
                ),),
                Expanded(child: HoverActiveIcon(
                  icon: TolyIcon.icon_right,
                  onTap: () => handleTap(CtrlType.right),
                ),),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const Spacer(),
                Expanded(
                  child: HoverActiveIcon(
                    icon: TolyIcon.icon_down,
                    onTap: () => handleTap(CtrlType.down),
                  ),
                ),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }

  void handleTap(CtrlType type) {
    onTapCtrl(type);
  }
}

class HoverActiveIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const HoverActiveIcon({Key? key, required this.icon, required this.onTap})
      : super(key: key);

  @override
  State<HoverActiveIcon> createState() => _HoverActiveIconState();
}

class _HoverActiveIconState extends State<HoverActiveIcon> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    Color color = _isHover ? Theme.of(context).primaryColor : Colors.black;
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onHover: _onHover,
        onExit: _onExit,
        child: Icon(
          widget.icon,
          color: color,
        ),
      ),
    );
  }

  void _onHover(PointerHoverEvent value) {
    setState(() {
      _isHover = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _isHover = false;
    });
  }
}
