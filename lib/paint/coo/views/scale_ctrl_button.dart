import 'package:flutter/material.dart';
import 'package:skeleton/app/global/toly_icon.dart';

import 'move_ctrl_button.dart';

class ScaleCtrlButton extends StatelessWidget {

  final CtrlTapCallback onTapCtrl;

  const ScaleCtrlButton({Key? key, required this.onTapCtrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Column(
        children: [
          const Spacer(),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(child: SizedBox(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8) ),
                      border: Border.all()
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: HoverActiveIcon(
                        icon: TolyIcon.icon_big,
                        onTap: () => handleTap(CtrlType.bigger),
                      ),
                    ),
                  ),
                ),),
                Expanded(child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8) ),
                        border: Border.all()
                    ),
                  child:Padding(
                    padding: EdgeInsets.all(4),
                    child: HoverActiveIcon(
                      icon: TolyIcon.icon_small,
                      onTap: () => handleTap(CtrlType.smaller),
                    ),
                  ),
                ),),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void handleTap(CtrlType type) {
    onTapCtrl(type);
  }
}

