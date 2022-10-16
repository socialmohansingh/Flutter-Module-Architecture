import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:test_package/module2/module2_navigaton.dart';

import 'di/module2_di.dart';

class Modile2 extends BaseModule<Module2Navigation> {
  Module2DI di = Module2DI();

  Modile2({
    required super.key,
    required super.onReceive,
    required super.onError,
  });

  @override
  Future<NavigationRouter> init(
    NavigationService navigationStack, {
    DeepLink? deepLink,
  }) async {
    var nav = Module2Navigation(navigationStack: navigationStack);
    await di.init(nav);
    return nav;
  }

  @override
  Future<void> setRootPage(
    Module2Navigation navigationRouter, {
    DeepLink? deepLink,
  }) async {
    navigationRouter.showFeature1Page();
  }

  @override
  Future<void> dispose({DeepLink? deepLink}) async {
    di.dispose();
  }
}
