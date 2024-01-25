import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:toly_menu/src/menu.dart';
import 'package:toly_menu/toly_menu.dart';
import '../menus/menu_scope/menu_scope.dart';
import 'menu_record.dart';
import 'top_logo.dart';
import 'top_bar.dart';

class TolyBookNavigation extends StatelessWidget {
  final Widget content;
  const TolyBookNavigation({super.key, required this.content});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Row(
        children: [
          DragToMoveWrap(
            child: Container(
              color: const Color(0xff001529),
              width: 210,
              child: Column(
                children: [
                  TopLogo(),
                  Expanded(child: MenuTreeView()),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ColoredBox(
                    color: const Color(0xffF2F2F2),
                    child: AppTopBar()),
                MenuRecord() ,
                Expanded(child: content)],
            ),
          )
        ],
      ),
    );
  }
}

class MenuTreeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MenuStore store = MenuScope.of(context);
    return TolyMenu(state: store.state, onSelect: store.select);
  }
}
