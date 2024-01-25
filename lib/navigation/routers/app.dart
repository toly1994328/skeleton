// import 'package:components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/app_navigation.dart';
import '../views/empty_panel.dart';
import 'dashboard.dart';
import 'draw.dart';
// import 'package:iroute/navigation/router/routers/anima.dart';
// import 'package:iroute/navigation/router/routers/dream.dart';
// import 'package:iroute/navigation/router/routers/render.dart';
// import 'package:iroute/navigation/router/routers/scroll.dart';
// import 'package:iroute/navigation/router/routers/touch.dart';
//
// import '../../transition/size_clip_transition.dart';
// import '../../views/app_navigation.dart';
// import '../../../pages/empty/empty_panel.dart';
// import 'dashboard.dart';
// import 'draw.dart';
// import 'layout.dart';

final RouteBase appRoute = ShellRoute(
  builder: (BuildContext context, GoRouterState state, Widget child) {
    return TolyBookNavigation(content: child);
  },
  routes: <RouteBase>[
    dashboardRouters,
    drawRouters,
    // touchRouters,
    // dreamRouters,
    // scrollRouters,
    // renderRouters,
    // layoutRouters,
    // animaRouters,
    // GoRoute(
    //   path: '/code',
    //   pageBuilder: (BuildContext context, GoRouterState state) {
    //     String? path = state.uri.queryParameters['path'];
    //     return CustomTransitionPage(
    //         transitionDuration: const Duration(milliseconds: 500),
    //         reverseTransitionDuration: const Duration(milliseconds: 500),
    //       child: CodeView(
    //         path: path ?? '',
    //       ),
    //       transitionsBuilder: (_, a1, a2, child) =>
    //       SizeClipTransition(
    //         animation: a1,
    //         secondaryAnimation: a2,
    //         child: child,
    //       )
    //       //     CupertinoPageTransition(
    //       //   primaryRouteAnimation: a1,
    //       //   secondaryRouteAnimation: a2,
    //       //   linearTransition: true,
    //       //   child: child,
    //       // ),
    //     );
    //   },
    // ),
    GoRoute(
      path: '/404',
      builder: (BuildContext context, GoRouterState state) {
        String msg = '无法访问: ${state.extra}';
        return EmptyPanel(msg: msg);
      },
    )
  ],
);
