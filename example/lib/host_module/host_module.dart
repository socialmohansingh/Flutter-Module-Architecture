import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:get_it/get_it.dart';
import 'package:test_package/host_module/di/host_di.dart';
import 'package:test_package/host_module/host_navigation_router.dart';

class HostModule extends BaseModule {
  HostDI di = HostDI();
  HostModule({
    required super.key,
    required super.onReceive,
    required super.onError,
  });

  @override
  Future<void> init(BaseNavigationService navigationRouter,
      {DeepLink? deepLink}) async {
    await di.init(HostNavigation(navigationRouter));
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
  Future<void> setRootPage({DeepLink? deepLink}) async {
    GetIt.instance.get<HostNavigation>().showFeature1Page();
  }

  @override
  Future<void> dispose({DeepLink? deepLink}) async {
    di.dispose();
  }
}
