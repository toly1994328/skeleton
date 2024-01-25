import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paint/paint.dart';
import 'package:skeleton/paint/object/game/main.dart';

import '../../paint/aeroplane/play_board.dart';
import '../../paint/coo/views/home_page.dart';
import '../../paint/object/digital/digital_page.dart';
import '../views/empty_panel.dart';

final RouteBase drawRouters = GoRoute(
  path: '/draw/:name',
  builder: (BuildContext context, GoRouterState state) {
    String? index = state.pathParameters['name'];
    Widget child = const EmptyPanel(msg: '暂未实现');
    switch (index) {
      case 'coo':
        child = CooPage();
        break;
      case 'aeroplane':
        child = AeroplaneBoard();
        break;
      case 'digital':
        child = DigitalPage();
        break;
      case 'game_box':
        child = GameBoxPage();
        break;
      case 'structure':
        child = StructureView();
        break;
      case 'arrow':
        child = ArrowPage();
        break;
    }
    return child;
  },
  routes: [
    // GoRoute(
    //     path: 'structure/:name',
    //     builder: (_,state){
    //       print("=======structure:${state.uri.toString()}===============");
    //
    //       return StructureView();
    //     }
    // )
  ]
);
