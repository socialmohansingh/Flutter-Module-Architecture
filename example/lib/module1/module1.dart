import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:get_it/get_it.dart';
import 'package:test_package/module1/di/module1_di.dart';
import 'package:test_package/module1/module1_navigaton.dart';

class Modile1 extends BaseModule {
  Module1DI di = Module1DI();
  Modile1({
    required super.key,
    required super.onReceive,
    required super.onError,
  });

  @override
  Future<void> init(BaseNavigationService navigationRouter,
      {DeepLink? deepLink}) async {
    await di.init(Module1Navigation(navigationRouter));
  }

  @override
  Future<void> setRootPage({DeepLink? deepLink}) async {
    GetIt.instance.get<Module1Navigation>().showFeature1Page();
  }

  @override
  Future<void> dispose({DeepLink? deepLink}) async {
    di.dispose();
  }
}
