import 'package:get_it/get_it.dart';

import '../module2_navigaton.dart';

class Module2DI {
  Future<void> init(Module2Navigation nav) async {
    // GetIt.I.pushNewScope();
    GetIt.I.registerSingleton(nav);
  }

  Future<void> dispose() async {
    GetIt.I.unregister(instance: GetIt.I.get<Module2Navigation>());
    // GetIt.I.popScope();
  }
}
