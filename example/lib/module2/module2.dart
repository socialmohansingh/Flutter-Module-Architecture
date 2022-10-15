import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:get_it/get_it.dart';
import 'package:test_package/module2/module2_navigaton.dart';

import 'di/module2_di.dart';

class Modile2 extends BaseModule {
  Module2DI di = Module2DI();

  Modile2({
    required super.key,
    required super.onReceive,
    required super.onError,
  });

  @override
  Future<void> init(BaseNavigationService navigationRouter,
      {DeepLink? deepLink}) async {
    await di.init(Module2Navigation(navigationRouter));
  }

  @override
  Future<void> setRootPage({DeepLink? deepLink}) async {
    GetIt.I.get<Module2Navigation>().showFeature1Page();
  }

  @override
  Future<void> dispose({DeepLink? deepLink}) async {
    di.dispose();
  }
}
