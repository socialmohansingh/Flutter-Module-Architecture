import 'package:get_it/get_it.dart';

import '../module1_navigaton.dart';

class Module1DI {
  Future<void> init(Module1Navigation nav) async {
    // GetIt.I.pushNewScope();
    GetIt.I.registerSingleton(nav);
  }

  Future<void> dispose() async {
    GetIt.I.unregister(instance: GetIt.I.get<Module1Navigation>());
    // GetIt.I.popScope();
  }
}
