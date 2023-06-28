import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_module_architecture/src/navigation/app_page.dart';
import 'package:flutter_module_architecture/src/navigation/navigation_cubit.dart';
import 'package:flutter_module_architecture/src/navigation/navigation_state.dart';

final GlobalKey<NavigatorState> urlHandlerRouterDelegateNavigatorKey =
    GlobalKey<NavigatorState>();

class UrlHandlerRouterDelegate extends RouterDelegate<NavigationRouteState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  String endPaths;
  final Future<bool> Function(BuildContext context) onWillPop;
  final Future<void> Function(NavigationRouteState configuration) updatePath;
  late BuildContext myContext;

  List<AppPage> initialPages;
  UrlHandlerRouterDelegate({
    required this.onWillPop,
    required this.initialPages,
    required this.updatePath,
    this.endPaths = "",
  });

  @override
  Widget build(BuildContext context) {
    myContext = context;
    final heroController = HeroController();
    return Navigator(
      key: urlHandlerRouterDelegateNavigatorKey,
      pages: List.unmodifiable(initialPages.map((e) => e.page)),
      observers: [heroController],
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }
        context.read<NavigationCubit>().pop();
        return true;
      },
    );
    ;
  }

  @override
  Future<bool> popRoute() async {
    return onWillPop(myContext);
  }

  @override
  Future<void> setNewRoutePath(NavigationRouteState configuration) async {
    if ((configuration.endPath ?? "").isNotEmpty) {
      return updatePath(configuration);
    }
  }

  @override
  NavigationRouteState? get currentConfiguration =>
      DefaultRoute(endPath: endPaths);

  @override
  GlobalKey<NavigatorState>? get navigatorKey =>
      urlHandlerRouterDelegateNavigatorKey;
}
