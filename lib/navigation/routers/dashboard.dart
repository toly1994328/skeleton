
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:iroute/pages/dashboard/chat_room.dart';
// import 'package:iroute/pages/dashboard/view_books.dart';

final RouteBase dashboardRouters = GoRoute(
  path: '/dashboard',
  redirect: (_,state) {
    if (state.fullPath == '/dashboard') {
      return '/dashboard/view';
    }
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: 'view',
      builder: (BuildContext context, GoRouterState state) {
        return const SizedBox();
      },
    ),
    GoRoute(
      path: 'chat/:roomId',
      builder: (BuildContext context, GoRouterState state) {
        String? roomId = state.pathParameters['roomId'];
        return  SizedBox();
      },
    ),
  ],
);
