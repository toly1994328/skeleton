import 'dart:math';

import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeleton/src/arrow_path/arrow/arrow_path.dart';
import 'package:skeleton/src/linker.dart';
import 'package:skeleton/src/paper.dart';

import 'navigation/menus/menu_scope/menu_scope.dart';
import 'navigation/routers/app.dart';
import 'navigation/transition/fade_page_transitions_builder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setSize();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    initialLocation: '/draw/coo',
    routes: <RouteBase>[appRoute],
    onException: (BuildContext ctx, GoRouterState state, GoRouter router) {
      router.go('/404', extra: state.uri.toString());
    },
  );

   late final MenuStore menuStore = MenuStore(
     activeMenu: '/draw/coo',
     expandMenus: ['/draw'],
     goRouter: _router,
   );


   // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MenuScope(
      notifier: menuStore,
      child:  MaterialApp.router(
        routerConfig:_router,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "宋体",
          primarySwatch: Colors.blue,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.macOS: FadePageTransitionsBuilder(),
            TargetPlatform.windows: FadePageTransitionsBuilder(),
            TargetPlatform.linux: FadePageTransitionsBuilder(),
          }),
        ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  Linker linker = Linker(start: Offset.zero, end: Offset(60, 80));

  late AnimationController ctrl = AnimationController(
    vsync:  this,
    duration: Duration(seconds: 3)
  )..addListener(() {
    linker.updateNodeAnchor(0, ctrl.value);
  });

  @override
  void initState() {
    super.initState();
    linker.appendByLength(0.5, 40,120*pi/180);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
            ctrl.forward(from: 0);
          },
          child: CustomPaint(
            painter: SkeletonPaper(
              linker: linker
            ),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              height: 300,
              width: 300,
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


