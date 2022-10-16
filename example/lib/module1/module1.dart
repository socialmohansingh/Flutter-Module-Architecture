import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:test_package/module1/di/module1_di.dart';
import 'package:test_package/module1/module1_navigaton.dart';

class Modile1 extends BaseModule<Module1Navigation> {
  Module1DI di = Module1DI();
  Modile1({
    required super.key,
    required super.onReceive,
    required super.onError,
  });

  @override
  Future<Module1Navigation> init(
    NavigationService navigationStack, {
    DeepLink? deepLink,
  }) async {
    var nav = Module1Navigation(navigationStack: navigationStack);
    await di.init(nav);
    return nav;
  }

  @override
  Future<void> setRootPage(
    Module1Navigation navigationRouter, {
    DeepLink? deepLink,
  }) async {
    navigationRouter.showFeature1Page();
  }

  @override
  Future<void> dispose({DeepLink? deepLink}) async {
    di.dispose();
  }
}
