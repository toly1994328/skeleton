import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../menus/menu_scope/menu_scope.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    // String? lable =  MenuScope.of(context).currentNode?.label;
    return DragToMoveWrap(
      child:  SizedBox(
        height: 36,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [Row(
            children: [
              SizedBox(width: 20,),
              RouteBackIndicator(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: RouterIndicator(),
              ),
              // Text(
              //   '$lable',
              //   style: TextStyle(fontSize: 14),
              // ),
              Spacer(),
            ],
          ),WindowButtons()]
        ),
      ),
    );
  }
}
class RouteBackIndicator extends StatefulWidget {
  const RouteBackIndicator({super.key});

  @override
  State<RouteBackIndicator> createState() => _RouteBackIndicatorState();
}

class _RouteBackIndicatorState extends State<RouteBackIndicator> {

  late GoRouterDelegate _delegate ;

  @override
  void initState() {
    super.initState();
    _delegate =  GoRouter.of(context).routerDelegate;
    _delegate.addListener(_onChange);
  }

  @override
  void dispose() {
    _delegate.removeListener(_onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasPush = _delegate.currentConfiguration.matches
        .whereType<ImperativeRouteMatch>().isNotEmpty;
    if(hasPush){
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: context.pop,
          child: Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.only(right: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xffE3E5E7),
                  borderRadius: BorderRadius.circular(6)
              ),
              child: Icon(Icons.arrow_back_ios_new,size: 14,)),
        ),
      );
    }
    return SizedBox();
  }

  void _onChange() {
    setState(() {

    });
  }
}
class RouterIndicator extends StatefulWidget {
  const RouterIndicator({super.key});

  @override
  State<RouterIndicator> createState() => _RouterIndicatorState();
}

class _RouterIndicatorState extends State<RouterIndicator> {
  late GoRouterDelegate _delegate;
  @override
  void initState() {
    super.initState();
    _delegate = GoRouter.of(context).routerDelegate;
    _delegate.addListener(_onRouterChange);
  }

  @override
  void dispose() {
    _delegate.removeListener(_onRouterChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<RouteMatch> matches = _delegate.currentConfiguration.matches;
    if(matches.isEmpty) return const SizedBox();
    RouteMatch match = _delegate.currentConfiguration.matches.last;

    return TolyBreadcrumb(
      fontSize: 12,
      items: pathToBreadcrumbItems(context, match.matchedLocation),
      onTapItem: (item) {
        if (item.to != null) {
          GoRouter.of(context).go(item.to!);
        }
      },
    );
  }

  void _onRouterChange() {
    setState(() {});
  }

  List<BreadcrumbItem> pathToBreadcrumbItems(
      BuildContext context, String path) {
    Uri uri = Uri.parse(path);
    List<BreadcrumbItem> result = [];
    String to = '';

    String distPath = '';
    for (String segment in uri.pathSegments) {
      distPath += '/$segment';
    }

    for (String segment in uri.pathSegments) {
      to += '/$segment';
      String? label;
      if(to=='/code'){
        label = '代码详情';
      }else{
        label = MenuScope.read(context).pathName(to);
      }

      if (label!=null&&label.isNotEmpty) {
        result
            .add(BreadcrumbItem(to: to, label: label, active: to == distPath));
      }
    }
    return result;
  }
}
