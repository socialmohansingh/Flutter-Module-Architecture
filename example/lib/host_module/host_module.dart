import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:test_package/host_module/di/host_di.dart';
import 'package:test_package/host_module/host_navigation_router.dart';

class HostModule extends BaseModule<HostNavigation> {
  HostDI di = HostDI();
  HostModule({
    required super.key,
    required super.onReceive,
    required super.onError,
  });

  @override
  Future<NavigationRouter> init(
    NavigationService navigationStack, {
    DeepLink? deepLink,
  }) async {
    var nav = HostNavigation(navigationStack: navigationStack);
    await di.init(nav);
    return nav;
  }

  @override
  Future<FeaturePage> pageWrapper(Widget child, {DeepLink? deepLink}) async {
    return FeaturePage(
      page: MaterialPage(
        child: MaterialApp(
          home: child,
        ),
      ),
    );
  }

  @override
  Future<void> setRootPage(
    HostNavigation navigationRouter, {
    DeepLink? deepLink,
  }) async {
    navigationRouter.showFeature1Page();
  }

  @override
  Future<void> dispose({DeepLink? deepLink}) async {
    di.dispose();
  }
}
