import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:toly_menu/toly_menu.dart';

import '../menu_tree.dart';
import 'menu_history.dart';

class MenuScope extends InheritedNotifier<MenuStore> {
  const MenuScope({super.key, required super.child, super.notifier});

  static MenuStore of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MenuScope>()!.notifier!;
  }

  static MenuStore read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<MenuScope>()!.notifier!;
  }
}

class MenuStore with ChangeNotifier {
  late MenuState _state;
  MenuState get state => _state;
  final GoRouter goRouter;
  final List<MenuHistory> _history = [];
  List<MenuHistory> get history => _history;

  MenuStore({
    List<String> expandMenus = const [],
    required this.goRouter,
    required String activeMenu,
  }) {
    _state = MenuState(
      expandMenus: expandMenus,
      activeMenu: activeMenu,
      items: rootMenu.children,
    );

    _history.add(MenuHistory(
      menuLabel: pathName(activeMenu) ?? activeMenu,
      menuPath: activeMenu,
    ));
    goRouter.routerDelegate.addListener(_onRouterChange);
  }

  MenuNode? get currentNode => queryMenuNodeByPath(
      MenuNode(
        path: '',
        label: '',
        deep: -1,
        children: _state.items,
      ),
      _state.activeMenu);

  String? pathName(String path) => queryMenuNodeByPath(
          MenuNode(
            path: '',
            label: '',
            deep: -1,
            children: _state.items,
          ),
          path)
      ?.label;

  void selectMenuPath(String path) {


    MenuNode root = MenuNode(
      path: '',
      label: '',
      deep: -1,
      children: _state.items,
    );
    List<MenuNode> result = findNodes(root, Uri.parse(path), 0, '/', []);
    if (result.isNotEmpty) {
      List<String> expandMenus = [];
      if (result.length > 1) {
        expandMenus.addAll(
            result.sublist(0, result.length - 1).map((e) => e.path).toList());
      }
      if(_shouldAddHistory){
        _history.add(MenuHistory(
          menuLabel: result.last.label,
          menuPath: result.last.path,
        ));
      }else{
        _shouldAddHistory = true;
      }
      print("=====selectMenuPath: ${result.last.path}===============");
      _state = state.copyWith(
          activeMenu: result.last.path, expandMenus: expandMenus);
    }
  }

  bool _shouldAddHistory = true;
  void selectHistory(String path) {
    _shouldAddHistory = false;
    goRouter.go(path);
  }

  void closeHistory(MenuHistory history) {
    int index = _history.indexOf(history);
    if(_history.length==1){
      return;
    }
    if(state.activeMenu!=history.menuPath){
      _history.remove(history);
      notifyListeners();
      return;
    }
    MenuHistory nextActiveHistory;
    if(index==_history.length-1){
      ///
      nextActiveHistory = _history[_history.length-2];
    }else{
      nextActiveHistory = _history[index+1];
    }
    _history.remove(history);
    selectHistory(nextActiveHistory.menuPath);
  }

  List<MenuNode> findNodes(
    MenuNode node,
    Uri uri,
    int deep,
    String prefix,
    List<MenuNode> result,
  ) {
    List<String> parts = uri.pathSegments;
    if (deep > parts.length - 1) {
      return result;
    }
    String target = parts[deep];
    if (node.children.isNotEmpty) {
      target = prefix + target;
      List<MenuNode> nodes =
          node.children.where((e) => e.path == target).toList();
      bool match = nodes.isNotEmpty;
      if (match) {
        MenuNode matched = nodes.first;
        result.add(matched);
        String nextPrefix = '${matched.path}/';
        findNodes(matched, uri, ++deep, nextPrefix, result);
      }
    }
    return result;
  }

  MenuNode? queryMenuNodeByPath(MenuNode node, String path) {
    if (node.path == path) {
      return node;
    }
    if (node.children.isNotEmpty) {
      for (int i = 0; i < node.children.length; i++) {
        MenuNode? result = queryMenuNodeByPath(node.children[i], path);
        if (result != null) {
          return result;
        }
      }
    }
    return null;
  }

  void select(MenuNode menu) {
    bool hasHistory = _history.where((e) => e.menuPath==menu.path).isNotEmpty;
    print("=====select: ${hasHistory}===============");
    if(hasHistory){
      _shouldAddHistory = false;
      goRouter.go(menu.path);
      return;
    }

    if (menu.isLeaf) {
      _state = state.copyWith(activeMenu: menu.path);
      goRouter.go(menu.path);
      _history.add(MenuHistory(
        menuLabel: menu.label,
        menuPath: menu.path,
      ));
      // notifyListeners();
    } else {
      List<String> menus = [];
      String path = menu.path.substring(1);
      List<String> parts = path.split('/');

      if (parts.isNotEmpty) {
        String path = '';
        for (String part in parts) {
          path += '/$part';
          menus.add(path);
        }
      }
      if (state.expandMenus.contains(menu.path)) {
        menus.remove(menu.path);
      }

      _state = state.copyWith(expandMenus: menus);
      notifyListeners();
    }
  }

  void _onRouterChange() {
    String path =
        goRouter.routerDelegate.currentConfiguration.last.matchedLocation;
    if (path != state.activeMenu) {
      selectMenuPath(path);
    }
  }

}
